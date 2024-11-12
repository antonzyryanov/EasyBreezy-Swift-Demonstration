//
//  RateAppViewController.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 19.09.2023.
//

import UIKit
import Foundation

class RateAppViewController: UIViewController {
    
    @IBOutlet weak var navigationView: ProfileMenuNavigationView!
    @IBOutlet weak var submitButton: PrimaryDarkBlueBottomButton!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var charactersQuantityLabel: UILabel!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var shadowView: UIView!
    
    
    let nc = NotificationCenter.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationView.configureWith(title: "Rate the App")
        navigationView.presentingViewController = self
        submitButton.title = "Submit"
        // Do any additional setup after loading the view.
        submitButton.tapAction = {
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "FeedbackViewController", bundle: nil)
                let onboardingCoursesDescriptionViewController = storyboard.instantiateViewController(withIdentifier: "FeedbackViewController")
                onboardingCoursesDescriptionViewController.modalPresentationStyle = .overCurrentContext
                self.present(onboardingCoursesDescriptionViewController, animated:true)
                self.shadowView.isHidden = false
            }
        }
        textView.delegate = self
        textView.textColor = UIColor(red: 206/255, green: 214/255, blue: 224/255, alpha: 1)
        textView.text = "Your Message"
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
           view.addGestureRecognizer(tap)
        nc.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        shadowView.isHidden = true
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @objc private func keyboardWillShow() {
        imageHeightConstraint.priority = UILayoutPriority(1000)
    }
    
    @objc private func keyboardWillHide() {
        imageHeightConstraint.priority = UILayoutPriority(1)
    }

}

extension RateAppViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor(red: 206/255, green: 214/255, blue: 224/255, alpha: 1) {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Your Message"
            textView.textColor = UIColor(red: 206/255, green: 214/255, blue: 224/255, alpha: 1)
        }
    }
    
}

extension RateAppViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.view.endEditing(true)
            return false
        }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        return numberOfChars < 140    // 10 Limit Value
    }
    
    func textViewDidChange(_ textView: UITextView) {
            charactersQuantityLabel.text = "\(textView.text.count)/140"
    }
    
}
