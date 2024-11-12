//
//  SocialMediaLoginView.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 17.09.2023.
//

import Foundation
import UIKit
import GoogleSignIn
import AuthenticationServices

class SocialMediaLoginView: UIView, XibLoadable {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromXib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupFromXib()
    }
    
    func customizeView() {
        
    }
    
    @IBAction func googleButtonTapped(_ sender: Any) {
        guard let viewController = self.viewController else { return }
        GIDSignIn.sharedInstance.signIn(
            withPresenting: viewController) { signInResult, error in
              guard let result = signInResult else {
                // Inspect error
                return
              }
              // If sign in succeeded, display the app's main content View.
                
            let user = signInResult?.user
                
            guard let emailAddress = user?.profile?.email, let givenName = user?.profile?.givenName  else { return }
            let userDefaults = UserDefaults.standard
            userDefaults.setValue(emailAddress, forKey: "googleEmail")
            userDefaults.setValue(givenName, forKey: "googleName")
                NotificationCenter.default.post(name: .init("google_sign_in"), object: nil)
//
  //           let fullName = user.profile?.name
//            let givenName = user.profile?.givenName
//            let familyName = user.profile?.familyName
//
//            let profilePicUrl = user.profile?.imageURL(withDimension: 320)
                
            }
          
    }
    
    @IBAction func appleLoginTapped(_ sender: Any) {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        
        guard let currentVC = UIApplication.topViewController() as? AuthViewController else { return }
        controller.delegate = currentVC
        controller.presentationContextProvider = currentVC
        
        controller.performRequests()
    }
    
    
}
