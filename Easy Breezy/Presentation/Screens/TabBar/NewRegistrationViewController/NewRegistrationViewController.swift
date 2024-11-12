//
//  NewLoginViewController.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 17.09.2023.
//

import UIKit

class NewRegistrationViewController: AuthViewController {
    
    
    @IBOutlet weak var emailTextField: AuthorizationTextField!
    @IBOutlet weak var userNameTextField: AuthorizationTextField!
    @IBOutlet weak var passwordTextField: AuthorizationTextField!
    @IBOutlet weak var createAccountButton: PrimaryDarkBlueBottomButton!
    @IBOutlet weak var rememberCheckmark: UIImageView!
    
    
    @IBOutlet weak var goBackButton: UIButton!
    
    var isNeeedToRemember: Bool = true {
        didSet {
            if isNeeedToRemember {
                rememberCheckmark.isHidden = false
            } else {
                rememberCheckmark.isHidden = true
            }
        }
    }
    
    private var viewModel: NewRegistrationViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        createAccountButton.title = "Create Account"
        emailTextField.valueNameLabel.text = "Email"
        passwordTextField.valueNameLabel.text = "Password"
        emailTextField.textField.placeholder = "Enter your email"
        passwordTextField.textField.placeholder = "Enter your password"
        passwordTextField.isPassword = true
        userNameTextField.textField.placeholder = "Enter your username"
        userNameTextField.valueNameLabel.text = "Username"
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
           view.addGestureRecognizer(tap)
        self.viewModel = NewRegistrationViewModel(viewController: self)
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(googleSignIn), name: .init("google_sign_in"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appleSignIn), name: .init("apple_sign_in"), object: nil)
        
        userNameTextField.tapAction = {
            print("TEST SKYRIM 4")
            self.userNameTextField.textField.becomeFirstResponder()
        }
        passwordTextField.tapAction = {
            print("TEST SKYRIM 5")
            self.passwordTextField.textField.becomeFirstResponder()
        }
        emailTextField.tapAction = {
            print("TEST SKYRIM 6")
            self.emailTextField.textField.becomeFirstResponder()
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
    
    @objc func googleSignIn() {
        let userDefaults = UserDefaults.standard
        if let googleEmail = userDefaults.string(forKey: "googleEmail") {
            self.emailTextField.textField.text = googleEmail
            self.userNameTextField.textField.text = googleEmail
            self.passwordTextField.textField.text = "GoogleAuth3471"
            self.createAccountButton.tapAction?()
            self.viewModel.authorizationType = "google"
        }
    }
    
    @objc func appleSignIn() {
        let userDefaults = UserDefaults.standard
            if let email = userDefaults.string(forKey: "appleEmail") {
                self.emailTextField.textField.text = email
                self.userNameTextField.textField.text = email
                self.passwordTextField.textField.text = "AppleAuth3471"
                self.createAccountButton.tapAction?()
                self.viewModel.authorizationType = "apple"
            }
    }
    
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("open_login_screen"), object: nil)
    }
    
    
    @IBAction func usernameTextFieldPressed(_ sender: Any) {
        print("TEST SKYRIM 1")
        self.userNameTextField.becomeFirstResponder()
    }
    
    
    @IBAction func emailTextFieldPressed(_ sender: Any) {
        print("TEST SKYRIM 2")
        self.emailTextField.becomeFirstResponder()
    }
    
    @IBAction func passwordTextFieldPressed(_ sender: Any) {
        print("TEST SKYRIM 3")
        self.passwordTextField.becomeFirstResponder()
    }
    
}

extension NewRegistrationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.view.endEditing(true)
            return false
        }
    
}
