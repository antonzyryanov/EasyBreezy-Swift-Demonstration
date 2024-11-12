//
//  NewRegistrationViewModel.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 17.09.2023.
//

import Foundation
import Alamofire
import UIKit

class NewRegistrationViewModel {
    
    let userDefaults = UserDefaults.standard
    
    var viewController: NewRegistrationViewController!
    
    var authorizationType: String = "email"
    
    init(viewController: NewRegistrationViewController) {
        self.viewController = viewController
        configure()
    }
    
    func configure() {
        setDelegates()
        setContinueButtonTapAction()
      //  checkAutoLoginOpportunity()
    }
    
    private func setDelegates() {
        self.viewController.emailTextField.textField.delegate = viewController
        self.viewController.passwordTextField.textField.delegate = viewController
    }
    
    private func setContinueButtonTapAction() {
        self.viewController.createAccountButton.tapAction = {
            self.handleAuthorization(isSuccessful: true)
//            guard let userName = self.viewController.userNameTextField.textField.text else { return }
//            guard let email = self.viewController.emailTextField.textField.text else { return }
//            guard let password = self.viewController.passwordTextField.textField.text else { return }
//            let userInfo: Parameters  = ["username":userName,"email": email,"password":password]
//            let registrationNetworkRepository = RegistrationNetworkRepository()
//            registrationNetworkRepository.registerAccount(userInfo: userInfo, completion: self.handleAuthorization(isSuccessful:))
        }
    }
    
    private func checkAutoLoginOpportunity() {
        if userLoginDataSaved() {
           checkLastSuccesfulAuthorizationDate()
        }
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
        self.viewController.emailTextField.textField.text = name
        self.viewController.passwordTextField.textField.text = password
        self.viewController.createAccountButton.tapAction?()
    }
    
    func handleAuthorization(isSuccessful: Bool) {
        if isSuccessful {
            if self.viewController.isNeeedToRemember {
                rememberUserLoginData()
            }
            UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
            let nc = NotificationCenter.default
            nc.post(name: Notification.Name("load_courses"), object: nil)
            EventTracker.shared.log(event: "registration", with: [:], and: ["username":UserProfile.shared.userInfo.user.username, "authorization": authorizationType])
        } else {
//            let alert = UIAlertController(title: "Authorization failed", message: "", preferredStyle: UIAlertController.Style.alert)
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//            viewController.present(alert, animated: true, completion: nil)
            viewController.userNameTextField.error = "Try another Username or Email"
        }
    }
    
    func rememberUserLoginData() {
        guard let name = self.viewController.emailTextField.textField.text else { return }
        guard let password = self.viewController.passwordTextField.textField.text else { return }
        userDefaults.set(true, forKey: "userLoginDataSaved")
        userDefaults.set(Date(), forKey: "lastSuccesfulAuthorizationDate")
        userDefaults.set(name, forKey: "userName")
        userDefaults.set(password, forKey: "userPassword")
    }
    
}
