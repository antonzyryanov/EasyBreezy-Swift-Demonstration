//
//  FeedbackViewController.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 20.09.2023.
//

import UIKit

class FeedbackViewController: UIViewController {
    
    @IBOutlet weak var goToMainButton: PrimaryDarkBlueBottomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goToMainButton.tapAction = {
            UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
        }
        goToMainButton.title = "Continue to Home"
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
}
