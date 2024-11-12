//
//  LoginViewController.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 29.12.2022.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var mainView: LoginView!
    
    var model: LoginModel!
    
    var presentAuthorizationScreenAction: (() -> (Void))?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewModel = LoginViewModel(model: self.model, view: self.mainView)
        viewModel.trackThatOnBoardingStepWasShown(index: 0)
    }
    
    func openAuthorizationScreen() {
        presentAuthorizationScreenAction?()
    }

}
