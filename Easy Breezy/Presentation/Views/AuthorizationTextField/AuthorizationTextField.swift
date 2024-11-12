//
//  AuthorizationTextField.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 17.09.2023.
//

import Foundation
import UIKit

class AuthorizationTextField: UIView, XibLoadable {
    
    @IBOutlet weak var backgroundView: RoundedCornersView!
    @IBOutlet weak var valueNameLabel: UILabel!
    @IBOutlet weak var eyeImageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    var isPassword = false {
        didSet {
            if isPassword {
                eyeImageView.isHidden = false
                isEyePressed = false
            } else {
                eyeImageView.isHidden = true
            }
        }
    }
    
    var isEyePressed = true {
        didSet {
            if isEyePressed {
                eyeImageView.image = UIImage(named:"login_eye_closed")
                textField.isSecureTextEntry = false
            } else {
                eyeImageView.image = UIImage(named: "login_eye_opened")
                textField.isSecureTextEntry = true
            }
        }
    }
    
    var error: String = "" {
        didSet {
            if error == "" {
                self.backgroundView.borderSize = 0
                errorLabel.isHidden = true
            } else {
                errorLabel.isHidden = false
                backgroundView.borderSize = 1
                errorLabel.text = error
            }
        }
    }
    
    var tapAction: (()->Void)? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromXib()
        var tapGesture = UITapGestureRecognizer(target: self, action: Selector("tapAction"))
        self.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupFromXib()
        var tapGesture = UITapGestureRecognizer(target: self, action: Selector("tapAction"))
        self.addGestureRecognizer(tapGesture)
    }
    
    func customizeView() {
        eyeImageView.isHidden = true
        errorLabel.isHidden = true
        backgroundView.borderSize = 0
    }
    
    
    @IBAction func eyePressed(_ sender: Any) {
        isEyePressed.toggle()
    }
    
    
    @IBAction func tapAction(_ sender: Any) {
        tapAction?()
    }
    
}
