//
//  AuthorizationViewModel.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 28.01.2023.
//

import Foundation
import UIKit
import Alamofire

enum AuthorizationMode: String {
    case login
    case register
}

class AuthorizationViewModel {
    
    let userDefaults = UserDefaults.standard
    
    var view: AuthorizationView!
    
    var authorizationMode: AuthorizationMode = .login {
        didSet {
            if authorizationMode == .login {
                setupLoginScreen()
            } else {
                setupRegisterScreen()
            }
        }
    }
    
    init(view: AuthorizationView) {
        self.view = view
        configure()
    }
    
    func configure() {
        guard let viewController = self.view.viewController as? AuthorizationViewController else { return }
        setDelegates(viewController)
        setupInterface()
        setAuthorizationModeSwitchButtonAction()
        setContinueButtonTapAction()
        checkAutoLoginOpportunity()
    }
    
    private func setDelegates(_ viewController: AuthorizationViewController) {
        self.view.emailTextField.delegate = viewController
        self.view.passwordTextField.delegate = viewController
        self.view.userNameTextField.delegate = viewController
    }
    
    private func setupInterface() {
        self.view.continueButton.title = "Login"
        self.view.emailTextField.isHidden = true
        self.view.emailTextField.isUserInteractionEnabled = false
        self.view.passwordTextField.isSecureTextEntry = true
    }
    
    private func setAuthorizationModeSwitchButtonAction() {
        self.view.authorizationModeSwitchButtonAction = {
            switch self.authorizationMode {
            case .login:
                self.authorizationMode = .register
            case .register:
                self.authorizationMode = .login
            }
        }
    }
    
    private func setContinueButtonTapAction() {
        self.view.continueButton.tapAction = {
            guard let userName = self.view.userNameTextField.text else { return }
            guard let email = self.view.emailTextField.text else { return }
            guard let password = self.view.passwordTextField.text else { return }
            
            
            switch self.authorizationMode {
            case .login:
                let userInfo: Parameters  = ["identifier":userName,"password":password]
                let loginNetworkRepository = LoginNetworkRepository()
                loginNetworkRepository.login(userInfo: userInfo, completion: self.handleAuthorization(isSuccessful:))
            case .register:
                let userInfo: Parameters  = ["username":userName,"email": email,"password":password]
                let registrationNetworkRepository = RegistrationNetworkRepository()
                registrationNetworkRepository.registerAccount(userInfo: userInfo, completion: self.handleAuthorization(isSuccessful:))
            }
        }
    }
    
    private func checkAutoLoginOpportunity() {
        if userLoginDataSaved() {
           checkLastSuccesfulAuthorizationDate()
        }
    }
    
    private func userLoginDataSaved() -> Bool {
        return userDefaults.bool(forKey: "userLoginDataSaved")
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
    
    private func autoLogin() {
        guard let name = userDefaults.string(forKey: "userName") else { return }
        guard let password = userDefaults.string(forKey: "userPassword") else { return }
        self.view.userNameTextField.text = name
        self.view.passwordTextField.text = password
        self.view.continueButton.tapAction?()
    }
    
    private func setupLoginScreen() {
        self.view.emailTextField.isHidden = true
        self.view.emailTextField.isUserInteractionEnabled = false
        self.view.authorizationModeSwitchButton.setTitle("Register", for: .normal)
        self.view.continueButton.title = "Login"
    }
    
    private func setupRegisterScreen() {
        self.view.emailTextField.isHidden = false
        self.view.emailTextField.isUserInteractionEnabled = true
        self.view.authorizationModeSwitchButton.setTitle("Login", for: .normal)
        self.view.continueButton.title = "Register"
    }
    
    func handleAuthorization(isSuccessful: Bool) {
        guard let viewController = self.view.viewController as? AuthorizationViewController else { return }
        if isSuccessful {
            if self.view.rememberMeSwitch.isOn {
                rememberUserLoginData()
            }
            viewController.dismiss(animated: true)
        } else {
            let alert = UIAlertController(title: "Authorization failed", message: "", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    func rememberUserLoginData() {
        guard let name = self.view.userNameTextField.text else { return }
        guard let password = self.view.passwordTextField.text else { return }
        userDefaults.set(true, forKey: "userLoginDataSaved")
        userDefaults.set(Date(), forKey: "lastSuccesfulAuthorizationDate")
        userDefaults.set(name, forKey: "userName")
        userDefaults.set(password, forKey: "userPassword")
    }
    
    func testAutoLogin() {
        let userInfo: Parameters  = ["identifier":"Testovich7","password":"Test1234"]
        let loginNetworkRepository = LoginNetworkRepository()
        loginNetworkRepository.login(userInfo: userInfo, completion: self.handleAuthorization(isSuccessful:))
    }
    
}
