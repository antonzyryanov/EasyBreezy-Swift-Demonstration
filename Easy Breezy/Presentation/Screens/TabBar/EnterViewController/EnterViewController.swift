//
//  EnterViewController.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 30.07.2023.
//

import UIKit
import Foundation

class EnterViewController: UIViewController {
    
    
    @IBOutlet weak var getStartedButton: PrimaryDarkBlueBottomButton!
    @IBOutlet weak var alreadyHaveAccountButton: SecondaryDarkBlueBottomButton!
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStartedButton.tapAction = {
            DispatchQueue.main.async {
                self.openRegistrationViewController()
            }
        }
        alreadyHaveAccountButton.tapAction = {
            DispatchQueue.main.async {
                self.openLoginViewController()
            }
        }
        // Do any additional setup after loading the view.
        checkAutoLoginOpportunity()
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(openLoginScreen), name: Notification.Name("open_login_screen"), object: nil)
        nc.addObserver(self, selector: #selector(openRegistrationScreen), name: Notification.Name("open_registration_screen"), object: nil)
    }
    
    private func checkAutoLoginOpportunity() {
        if userLoginDataSaved() {
           checkLastSuccesfulAuthorizationDate()
        }
    }
    
    @objc private func openLoginScreen() {
        self.view.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.openLoginViewController()
            self.view.isUserInteractionEnabled = true
        }
    }
    
    @objc private func openRegistrationScreen() {
        self.view.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.openRegistrationViewController()
            self.view.isUserInteractionEnabled = true
        }
    }
    
    private func openRegistrationViewController() {
        let storyboard = UIStoryboard(name: "NewRegistrationViewController", bundle: nil)
            guard let enterViewController = storyboard.instantiateViewController(withIdentifier: "NewRegistrationViewController") as? NewRegistrationViewController else { return }
            enterViewController.modalPresentationStyle = .overCurrentContext
            self.present(enterViewController, animated: true)
    }
    
    private func openLoginViewController() {
        let storyboard = UIStoryboard(name: "NewLoginViewController", bundle: nil)
            guard let enterViewController = storyboard.instantiateViewController(withIdentifier: "NewLoginViewController") as? NewLoginViewController else { return }
            enterViewController.modalPresentationStyle = .overCurrentContext
            self.present(enterViewController, animated: true)
    }
    
    private func checkLastSuccesfulAuthorizationDate() {
        guard let lastSuccesfulAuthorizationDate = UserDefaults.standard.object(forKey: "lastSuccesfulAuthorizationDate") as? Date else { return }
        let passedDaysFromLastSuccesfulLogin = Date().days(from: lastSuccesfulAuthorizationDate)
        if passedDaysFromLastSuccesfulLogin <= 90 {
            userDefaults.set(Date(), forKey: "lastSuccesfulAuthorizationDate")
            autoLogin()
        } else {
            userDefaults.set(false, forKey: "userLoginDataSaved")
        }
    }
    
    private func userLoginDataSaved() -> Bool {
        return userDefaults.bool(forKey: "userLoginDataSaved")
        
    }
    
    private func autoLogin() {
        guard let name = userDefaults.string(forKey: "userName") else { return }
        guard let password = userDefaults.string(forKey: "userPassword") else { return }
        DispatchQueue.main.async {
        let storyboard = UIStoryboard(name: "NewLoginViewController", bundle: nil)
            guard let enterViewController = storyboard.instantiateViewController(withIdentifier: "NewLoginViewController") as? NewLoginViewController else { return }
            enterViewController.modalPresentationStyle = .overCurrentContext
            self.present(enterViewController, animated: true)
            enterViewController.rememberedUserName = name
            enterViewController.rememberedPassword = password
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
