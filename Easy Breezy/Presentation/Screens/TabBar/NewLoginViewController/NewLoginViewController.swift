//
//  NewLoginViewController.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 17.09.2023.
//

import UIKit

class NewLoginViewController: AuthViewController {
    
    
    @IBOutlet weak var userNameTextField: AuthorizationTextField!
    
    @IBOutlet weak var passwordTextField: AuthorizationTextField!
    
    @IBOutlet weak var loginButton: PrimaryDarkBlueBottomButton!
    
    @IBOutlet weak var loaderView: LoaderView!
    
    @IBOutlet weak var rememberCheckmark: UIImageView!
    
    
    @IBOutlet weak var goBackButton: UIButton!
    
    var rememberedUserName: String =  ""
    var rememberedPassword: String =  ""
    
    var isNeeedToRemember: Bool = true {
        didSet {
            if isNeeedToRemember {
                rememberCheckmark.isHidden = false
            } else {
                rememberCheckmark.isHidden = true
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loaderView.isHidden = true
        loginButton.title = "Login"
        userNameTextField.valueNameLabel.text = "Username"
        passwordTextField.valueNameLabel.text = "Password"
        userNameTextField.textField.placeholder = "Enter your username"
        passwordTextField.textField.placeholder = "Enter your password"
        passwordTextField.isPassword = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
           view.addGestureRecognizer(tap)
        let viewModel = NewLoginViewModel(viewController: self)
        NotificationCenter.default.addObserver(self, selector: #selector(googleSignIn), name: .init("google_sign_in"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appleSignIn), name: .init("apple_sign_in"), object: nil)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if rememberedUserName != "" && rememberedPassword != "" {
            self.userNameTextField.textField.text = rememberedUserName
            self.passwordTextField.textField.text = rememberedPassword
            self.loginButton.tapAction?()
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
    
    @IBAction func rememberButtonPressed(_ sender: Any) {
        isNeeedToRemember.toggle()
    }
    
    
    @IBAction func goBackButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    @IBAction func createAccountButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("open_registration_screen"), object: nil)
    }
    
    @objc func googleSignIn() {
        let userDefaults = UserDefaults.standard
        if let googleEmail = userDefaults.string(forKey: "googleEmail") {
            self.userNameTextField.textField.text = googleEmail
            self.passwordTextField.textField.text = "GoogleAuth3471"
            self.loginButton.tapAction?()
        }
    }
    
    @objc func appleSignIn() {
        let userDefaults = UserDefaults.standard
        if let email = userDefaults.string(forKey: "appleEmail") {
            self.userNameTextField.textField.text = email
            self.passwordTextField.textField.text = "AppleAuth3471"
            self.loginButton.tapAction?()
        }
    }
    
}

extension NewLoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.view.endEditing(true)
            return false
        }
    
}
