//
//  CourseCompletedViewController.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 20.09.2023.
//

import UIKit

class CourseCompletedViewController: UIViewController {
    
    @IBOutlet weak var courseName: UILabel!
    
    @IBOutlet weak var goToMainButton: PrimaryDarkBlueBottomButton!
    
    @IBOutlet weak var rateStarsView: RateStarsView!
    
    @IBOutlet weak var commentHeight: NSLayoutConstraint!
    
    @IBOutlet weak var thanksHeight: NSLayoutConstraint!
    
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    
    @IBOutlet weak var textView: UITextField!
    
    let nc = NotificationCenter.default
    
    var currentCourseName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        thanksHeight.priority = UILayoutPriority(1000)
        goToMainButton.title = "Submit"
        goToMainButton.tapAction = {
            if self.goToMainButton.title == "Submit" {
                self.goToMainButton.title = "Go to Main"
                self.thanksHeight.priority = UILayoutPriority(1)
                self.commentHeight.priority = UILayoutPriority(1000)
                self.rateStarsView.isUserInteractionEnabled = false
            } else {
                UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
            }
        }
        rateStarsView.starsHeightAndWeight = 24
        courseName.text = currentCourseName
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
           view.addGestureRecognizer(tap)
        nc.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        textView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @objc private func keyboardWillShow() {
        self.imageHeight.priority = UILayoutPriority(1000)
    }
    
    @objc private func keyboardWillHide() {
        self.imageHeight.priority = UILayoutPriority(1)
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

}

extension CourseCompletedViewController: UITextFieldDelegate {
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.view.endEditing(true)
            return false
    }
        
}
