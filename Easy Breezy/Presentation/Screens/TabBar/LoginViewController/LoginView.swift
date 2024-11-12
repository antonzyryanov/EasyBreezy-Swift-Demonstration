//
//  LoginView.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 29.12.2022.
//

import UIKit

class LoginView: UIView {
    
    @IBOutlet weak var onBoardingSheet: OnBoardingSheetView!
    
    @IBOutlet weak var primaryButton: PrimaryButton!
    
    func configure(with model: LoginModel, and index: Int = 0) {
        if model.onBoardings.count == 0 { return }
        if model.onBoardings[index].type == .subscription {
            self.onBoardingSheet.imageViewHeight.constant = 0
            self.onBoardingSheet.subscriptionViewHeight.constant = 300
            self.onBoardingSheet.subscriptionView.isHidden = false
            self.onBoardingSheet.subscriptionView.isUserInteractionEnabled = true
            self.onBoardingSheet.subscriptionViewHolder.priority = UILayoutPriority(1)
        }
        self.onBoardingSheet.imageView.image = UIImage(named: model.onBoardings[index].image)
        self.onBoardingSheet.textLabel.text = model.onBoardings[index].text
    }

}
