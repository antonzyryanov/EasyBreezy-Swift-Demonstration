//
//  AuthorizationView.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 27.01.2023.
//

import UIKit

class AuthorizationView: UIView {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var continueButton: PrimaryButton!
    @IBOutlet weak var authorizationModeSwitchButton: UIButton!
    @IBOutlet weak var rememberMeSwitch: UISwitch!
    
    var authorizationModeSwitchButtonAction: (()->(Void))?
    
    @IBAction func authorizationModeSwitchButtonAction(_ sender: Any) {
        authorizationModeSwitchButtonAction?()
    }
    
}
