//
//  MainViewController.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 30.11.2022.
//

import UIKit
import Foundation

class MainViewController: BaseTabBarController {
    
    let nc = NotificationCenter.default
    let defaults = UserDefaults.standard

    fileprivate func extractedFunc() {
        self.tabBar.isHidden = true
        self.tabBar.isUserInteractionEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chooseScreenToShow()
        
     //   getCourses()
        hideTabBar()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 9.0) {
//            self.testAppsFlyer()
//            guard let url = URL(string: "https://app.appsflyer.com/id1663670702?pid=conversionTest1&idfa=07F73747-0B4D-4BE8-9784-8446120CE2B3") else { return }
//            UIApplication.shared.open(url)
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 35.0) {
//            guard let url = URL(string: "https://app.appsflyer.com/id1663670702?pid=conversionTest1&idfa=07F73747-0B4D-4BE8-9784-8446120CE2B3") else { return }
//            UIApplication.shared.open(url)
//        }
        nc.addObserver(self, selector: #selector(loginHappened), name: Notification.Name("load_courses"), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard let coursesViewController = self.viewControllers?.first as? CoursesViewController else { return }
        coursesViewController.viewModel = CoursesViewModel(model: CoursesModel(courses: FakeModelGenerator.shared.generateFakeCourses()) , view: coursesViewController.mainView)
        
       // loadCourses()
    }
    
    private func chooseScreenToShow() {
        
        if defaults.object(forKey: "isOnBoardingPassed") is Bool {
            showAuthorizationScreen()
        } else {
            showOnBoardingViewController()
        }
    }
    
    private func getCourses() {
        let livesNetworkRepository = CoursesNetworkRepository()
        livesNetworkRepository.getCourses {_ in
        }
    }
    
    private func hideTabBar() {
        self.tabBar.isHidden = true
        self.tabBar.isUserInteractionEnabled = false
    }
    
    private func showOnBoardingViewController() {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "OnBoardingQuestionsViewController", bundle: nil)
            let loginViewController = storyboard.instantiateViewController(withIdentifier: "OnBoardingQuestionsViewController") as! OnBoardingQuestionsViewController
            loginViewController.modalPresentationStyle = .fullScreen
            self.present(loginViewController, animated: true)
        }
    }
    
    private func showAuthorizationScreen() {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "EnterViewController", bundle: nil)
            let authorizationViewController = storyboard.instantiateViewController(withIdentifier: "EnterViewController") as! EnterViewController
            authorizationViewController.modalPresentationStyle = .fullScreen
            self.present(authorizationViewController, animated: true)
        }
    }
    
    fileprivate func loadLives() {
        let livesNetworkRepository = LivesNetworkRepository()
        livesNetworkRepository.getLives { lives in
//            guard let livesData = lives?.data.first else {
//                return
//            }
            UserProfile.shared.numberOfLifes = 3 //livesData.attributes.count
            UserProfile.shared.livesRanOutDate  = nil // livesData.attributes.emptyAt
//            LivesManager.shared.updateLives()
//            ProgressManager.shared.updateProgress()
            self.loadProgresses()
        }
    }
    
    fileprivate func loadProgresses() {
        let progressesNetworkRepository = ProgressesNetworkRepository()
        progressesNetworkRepository.getProgresses {
            self.closeLoader()
            if !(self.defaults.object(forKey: "isPaywallWasShown") is Bool) {
                self.defaults.set(true, forKey: "isPaywallWasShown")
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: "TrialOfferViewController", bundle: nil)
                    guard let trialOfferViewController = storyboard.instantiateViewController(withIdentifier: "TrialOfferViewController") as? TrialOfferViewController else { return }
                    trialOfferViewController.modalPresentationStyle = .overCurrentContext
                    trialOfferViewController.previousScreen = "onboarding"
                    self.present(trialOfferViewController, animated:true)
                }
            }
        }
    }
    
    @objc func loginHappened() {
        loadCourses()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.closeLoader()
        }
        
    }
    
    func loadCourses() {
        let coursesNetworkRepository = CoursesNetworkRepository()
        coursesNetworkRepository.getCourses { courses in
            var localCourses: [Course] = []
            if let courses = courses {
                localCourses = courses
            } else {

            }
            guard let coursesViewController = self.viewControllers?.first as? CoursesViewController else { return }
            coursesViewController.viewModel = CoursesViewModel(model: CoursesModel(courses: localCourses), view: coursesViewController.mainView)
            self.loadLives()
            coursesViewController.viewModel.refreshProgress()
        }
        
    }
    
    private func closeLoader() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            guard let coursesViewController = self.viewControllers?.first as? CoursesViewController,
            let loaderView = coursesViewController.loaderView else { return }
            loaderView.isHidden = true
        }
    }
    
    private func testAppsFlyer() {
        let headers = [
          "accept": "application/json",
          "af_sig": "b07b242f18f392bcc6e6bad5354cea9e41664842e4cf64a35fe348f0e89489f6",
          "af_request_epoch_ms": "1682885925"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://gcdsdk.appsflyer.com/install_data/v5.0/id1663670702?device_id=1682881904264-1753524")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
          if (error != nil) {
            print(error as Any)
          } else {
            let httpResponse = response as? HTTPURLResponse
            print(httpResponse)
          }
        })

        dataTask.resume()
    }

}

