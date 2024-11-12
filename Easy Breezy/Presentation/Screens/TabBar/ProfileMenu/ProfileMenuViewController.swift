//
//  ProfileMenuViewController.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 12.08.2023.
//

import UIKit
import Foundation
import GoogleSignIn

class ProfileMenuViewController: UIViewController {
    
    
    @IBOutlet var menuView: RoundedCornersView!
    
    @IBOutlet weak var languageButton: UIButton!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isOpaque = false
        // Do any additional setup after loading the view.
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        self.menuView.frame = CGRect(x: -self.menuView.frame.width, y: self.menuView.frame.minY, width: self.menuView.frame.width, height: self.menuView.frame.height)
        let originalTransform = self.menuView.transform
            //let scaledTransform = originalTransform.scaledBy(x: 0.2, y: 0.2)
        let translatedTransform = originalTransform.translatedBy(x: self.menuView.frame.width, y: 0)
            UIView.animate(withDuration: 10.0, animations: {
                self.menuView.transform = translatedTransform
            })
    }
    
    
    
    @IBAction func userTappedOnSpaceOutOfMenu(_ sender: Any) {
        self.dismissDetail()
    }
    
    
    
    @IBAction func languageButtonTapped(_ sender: Any) {
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "LanguageSelectionViewController", bundle: nil)
                let languageSelectionViewController = storyboard.instantiateViewController(withIdentifier: "LanguageSelectionViewController")
                languageSelectionViewController.modalPresentationStyle = .overCurrentContext
                self.present(languageSelectionViewController, animated: true)
            }
    }
    
    
    @IBAction func premiumButtonTapped(_ sender: Any) {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "TrialOfferViewController", bundle: nil)
            guard let trialOfferViewController = storyboard.instantiateViewController(withIdentifier: "TrialOfferViewController") as? TrialOfferViewController else { return }
            trialOfferViewController.modalPresentationStyle = .overCurrentContext
            trialOfferViewController.previousScreen = "main_screen"
            self.present(trialOfferViewController, animated:true)
        }
    }
    
    
    @IBAction func termsOfUseAndPrivacyButtonTapped(_ sender: Any) {
        
        let alert = UIAlertController(title: "Terms of Use and Privacy Policy", message: "Do you wish to save this Demo Settings?", preferredStyle: .alert)
        let privacyPolicy = UIAlertAction(title: "Privacy Policy", style: UIAlertAction.Style.default, handler: {
                        (_)in
                            guard let url = URL(string: "https://www.privacypolicygenerator.info/live.php?token=muo1p676PnDgz0JOwckO53Y22FnLB6l4") else {
                              return //be safe
                            }

                            if #available(iOS 10.0, *) {
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            } else {
                                UIApplication.shared.openURL(url)
                            }
                    })
        let termsOfUse = UIAlertAction(title: "Terms Of Use", style: UIAlertAction.Style.default, handler: {
                        (_)in
                            guard let url = URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/") else {
                              return //be safe
                            }

                            if #available(iOS 10.0, *) {
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            } else {
                                UIApplication.shared.openURL(url)
                            }
                    })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: {
                        (_)in
                        //do another thing
                    })
     alert.addAction(privacyPolicy)
     alert.addAction(termsOfUse)
     alert.addAction(cancelAction)
     self.present(alert, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func rateAppButtonPressed(_ sender: Any) {
        DispatchQueue.main.async {
        let storyboard = UIStoryboard(name: "RateAppViewController", bundle: nil)
        let onBoardingQuestionsViewController = storyboard.instantiateViewController(withIdentifier: "RateAppViewController")
            onBoardingQuestionsViewController.modalPresentationStyle = .overCurrentContext
            self.present(onBoardingQuestionsViewController, animated: true)
        }
    }
    
    
    @IBAction func deleteAccountButtonPressed(_ sender: Any) {
        defaults.setValue(false, forKey: "userLoginDataSaved")
        DispatchQueue.main.async {
        let storyboard = UIStoryboard(name: "EnterViewController", bundle: nil)
        let enterViewController = storyboard.instantiateViewController(withIdentifier: "EnterViewController")
            enterViewController.modalPresentationStyle = .overCurrentContext
            self.present(enterViewController, animated: true)
        }
        GIDSignIn.sharedInstance.signOut()
    }
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        defaults.setValue(false, forKey: "userLoginDataSaved")
        DispatchQueue.main.async {
        let storyboard = UIStoryboard(name: "EnterViewController", bundle: nil)
        let enterViewController = storyboard.instantiateViewController(withIdentifier: "EnterViewController")
            enterViewController.modalPresentationStyle = .overCurrentContext
            self.present(enterViewController, animated: true)
        }
        GIDSignIn.sharedInstance.signOut()
    }
    
    //    DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
//        let storyboard = UIStoryboard(name: "LoadingProcessViewController", bundle: nil)
//        let loadingProcessViewController = storyboard.instantiateViewController(withIdentifier: "LoadingProcessViewController")
//        loadingProcessViewController.modalPresentationStyle = .overCurrentContext
//        self.presentDetail(loadingProcessViewController)
//    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {

        if let swipeGesture = gesture as? UISwipeGestureRecognizer {

            switch swipeGesture.direction {
            case .right:
                print("Swiped right")
            case .down:
                print("Swiped down")
            case .left:
                self.dismissDetail()
            case .up:
                print("Swiped up")
            default:
                break
            }
        }
    }
    
}
