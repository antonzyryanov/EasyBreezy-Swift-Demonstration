//
//  AuthViewController.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 16.11.2023.
//

import UIKit
import AuthenticationServices

class AuthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension AuthViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let credentials as ASAuthorizationAppleIDCredential:
            let email = credentials.user + "@easybreezy.com"
            let userDefaults = UserDefaults.standard
            userDefaults.setValue(email, forKey: "appleEmail")
            userDefaults.setValue(email, forKey: "appleName")
                NotificationCenter.default.post(name: .init("apple_sign_in"), object: nil)
        default:
            break
        }
    }
}

extension AuthViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
    
}
