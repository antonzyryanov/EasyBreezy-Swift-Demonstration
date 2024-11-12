//
//  CoursesViewController.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 03.12.2022.
//

import UIKit
import Appodeal
import AppTrackingTransparency
import AdSupport

class CoursesViewController: UIViewController {
    
    @IBOutlet var mainView: CoursesView!
    @IBOutlet weak var loaderView: LoaderView!
    var model: CoursesModel!
    var viewModel: CoursesViewModel!
    
    var isCourseLockedNotificationShown: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if viewModel == nil {
            self.viewModel = CoursesViewModel(model: CoursesModel(courses: []), view: mainView)
        }
        self.mainView.exerciseTopView.toAllCoursesLabel.isHidden = true
        self.mainView.exerciseTopView.themeName.isHidden = true
        self.mainView.exerciseTopView.navigationArrow.isHidden = true
        self.mainView.exerciseTopView.toAllCoursesButton.isUserInteractionEnabled = false
        self.mainView.exerciseTopView.courseProgressBar.isHidden = true
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(refreshNumberOfLifes), name: Notification.Name("numberOfLifesChanged"), object: nil)
        nc.addObserver(self, selector: #selector(lifesRanOut), name: Notification.Name("lifesRanOut"), object: nil)
        nc.addObserver(self, selector: #selector(updateProgress), name: Notification.Name("updateProgress"), object: nil)
        nc.addObserver(self, selector: #selector(coursePassedAlert), name: Notification.Name("coursePassed"), object: nil)
        loaderView.frame = self.view.frame
    }
    
    override func viewWillAppear(_ animated: Bool) {
        var courses: [Course] = []
        for course in viewModel.model.courses {
            for courseProgress in UserProgressInfo.shared.coursesProgress {
                if courseProgress.key == course.title {
                    courses.append(Course(title: course.title, image: course.image, completionPercentage: courseProgress.value, courseData: CourseData(id: course.courseData.id, attributes: course.courseData.attributes)))
                }
            }
        }
        self.viewModel = CoursesViewModel(model: CoursesModel(courses: courses), view: mainView)
        mainView.layoutIfNeeded()
        mainView.layoutSubviews()
        let lifesViewModel = LifesViewModel(view: self.mainView.exerciseTopView.lifesView)
        lifesViewModel.set(numberOfLifes: UserProfile.shared.numberOfLifes)
        requestPermission()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Appodeal.hideBanner()
    }
    
    func showCourseLockedNotification() {
        if isCourseLockedNotificationShown { return }
        let view = CourseLockedNotificationView()
        view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 54)
        view.tapAction = {
            view.removeFromSuperview()
            self.isCourseLockedNotificationShown = false
        }
        self.mainView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor).isActive = true
        view.widthAnchor.constraint(equalTo: self.mainView.widthAnchor)
        view.heightAnchor.constraint(equalToConstant: 104).isActive = true
        self.isCourseLockedNotificationShown = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            if self.isCourseLockedNotificationShown {
                view.removeFromSuperview()
                self.isCourseLockedNotificationShown = false
            }
        }
    }
    
    @objc func refreshNumberOfLifes() {
        let lifesViewModel = LifesViewModel(view: self.mainView.exerciseTopView.lifesView)
        lifesViewModel.set(numberOfLifes: UserProfile.shared.numberOfLifes)
    }
    
    @objc func lifesRanOut() {
        viewWillAppear(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.viewModel.presentNoLifesAlert()
        }
    }
    
    @objc func updateProgress() {
        viewWillAppear(true)
    }
    
    @objc func coursePassedAlert() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.viewModel.presentCoursePassedAlert()
        }
    }
    
    func requestPermission() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .authorized:
                    // Tracking authorization dialog was shown
                    // and we are authorized
                    print("Authorized")
                    
                    // Now that we are authorized we can get the IDFA
                    print(ASIdentifierManager.shared().advertisingIdentifier)
                case .denied:
                    // Tracking authorization dialog was
                    // shown and permission is denied
                    print("Denied")
                case .notDetermined:
                    // Tracking authorization dialog has not been shown
                    print("Not Determined")
                case .restricted:
                    print("Restricted")
                @unknown default:
                    print("Unknown")
                }
            }
        }
    }

}
