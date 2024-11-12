//
//  OnboardingAnswerItemView.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 03.08.2023.
//

import Foundation
import UIKit

class OnboardingAnswerItemView: UIView, XibLoadable, ContainerViewSupporting {
    
    @IBOutlet weak var backgroundView: RoundedCornersView!
    
    @IBOutlet weak var chosenIndicator: RoundedCornersView!

    @IBOutlet weak var emojiImage: UIImageView!
    
    @IBOutlet weak var backgroundShadowView: RoundedCornersView!
    
    @IBOutlet weak var answerLabel: UILabel!
    
    @IBOutlet weak var chosenIndicatorBorderView: RoundedCornersView!
    var heightInContainer: CGFloat = 777
    
    var itemChosenAction: (()->Void)?
    
    var isChosen: Bool = false {
        didSet {
            if isChosen {
                backgroundView.backgroundColor = UIColor(red: 99/255, green: 181/255, blue: 255/255, alpha: 1)
                backgroundShadowView.backgroundColor = UIColor(red: 0/255, green: 98/255, blue: 186/255, alpha: 1)
                chosenIndicator.isHidden = false
                answerLabel.textColor = .white
                NotificationCenter.default.post(Notification(name: .init("onboarding_answer_chosen"),userInfo: ["answer":answerLabel.text ?? ""]))
                NotificationCenter.default.post(Notification(name: .init("onboarding_answer_type"),userInfo: ["answerType": "single" ?? ""]))
            } else {
                backgroundView.backgroundColor = UIColor(red: 201/255, green: 230/255, blue: 255/255, alpha: 1)
                backgroundShadowView.backgroundColor = UIColor(red: 80/255, green: 172/255, blue: 255/255, alpha: 1)
                chosenIndicator.isHidden = true
                answerLabel.textColor = UIColor(red: 56/255, green: 161/255, blue: 255/255, alpha: 1)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromXib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupFromXib()
    }
    
    func customizeView() {
        chosenIndicator.isHidden = true
        chosenIndicatorBorderView.borderSize = 1
    }
    
    @IBAction func tapAction(_ sender: Any) {
        itemChosenAction?()
        isChosen.toggle()
    }
    
}
