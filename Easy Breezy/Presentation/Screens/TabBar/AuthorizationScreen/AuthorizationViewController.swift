//
//  AuthorizationViewController.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 27.01.2023.
//

import UIKit

class AuthorizationViewController: UIViewController {
    
    @IBOutlet var mainView: AuthorizationView!
    var viewModel: AuthorizationViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = AuthorizationViewModel(view: self.mainView)
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}


extension AuthorizationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}
