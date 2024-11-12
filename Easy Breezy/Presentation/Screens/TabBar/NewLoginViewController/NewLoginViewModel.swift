//
//  NewLoginViewModel.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 17.09.2023.
//

import Foundation
import Alamofire
import UIKit

class NewLoginViewModel {
    
    let userDefaults = UserDefaults.standard
    
    var viewController: NewLoginViewController!
    
    init(viewController: NewLoginViewController) {
        self.viewController = viewController
        configure()
    }
    
    func configure() {
        setDelegates()
        setContinueButtonTapAction()
        checkAutoLoginOpportunity()
    }
    
    private func setDelegates() {
        self.viewController.userNameTextField.textField.delegate = viewController
        self.viewController.passwordTextField.textField.delegate = viewController
    }
    
    private func setContinueButtonTapAction() {
        self.viewController.loginButton.tapAction = {
            self.viewController.view.isUserInteractionEnabled = false
            self.viewController.loaderView.isHidden = false
            guard let email = self.viewController.userNameTextField.textField.text else { return }
            guard let password = self.viewController.passwordTextField.textField.text else { return }
            let userInfo: Parameters  = ["identifier":email,"password":password]
            let loginNetworkRepository = LoginNetworkRepository()
            loginNetworkRepository.login(userInfo: userInfo,completion: self.handleAuthorization(isSuccessful:))
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
        self.viewController.userNameTextField.textField.text = name
        self.viewController.passwordTextField.textField.text = password
        self.viewController.loginButton.tapAction?()
    }
    
    func handleAuthorization(isSuccessful: Bool) {
        self.viewController.view.isUserInteractionEnabled = true
        self.viewController.loaderView.isHidden = false
        if isSuccessful {
            if self.viewController.isNeeedToRemember {
                rememberUserLoginData()
            }
            UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
            let nc = NotificationCenter.default
            nc.post(name: Notification.Name("load_courses"), object: nil)
        } else {
//            let alert = UIAlertController(title: "Authorization failed", message: "", preferredStyle: UIAlertController.Style.alert)
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//            viewController.present(alert, animated: true, completion: nil)
            self.viewController.userNameTextField.error = "Wrong User Name or Password"
        }
    }
    
    func rememberUserLoginData() {
        guard let name = self.viewController.userNameTextField.textField.text else { return }
        guard let password = self.viewController.passwordTextField.textField.text else { return }
        userDefaults.set(true, forKey: "userLoginDataSaved")
        userDefaults.set(Date(), forKey: "lastSuccesfulAuthorizationDate")
        userDefaults.set(name, forKey: "userName")
        userDefaults.set(password, forKey: "userPassword")
    }
    
}
