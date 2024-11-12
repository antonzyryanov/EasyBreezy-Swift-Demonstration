//
//  FunnelStepView.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 08.12.2022.
//

import UIKit

class FunnelStepView: CustomDashedView, XibLoadable, ContainerViewSupporting, HorisontalContainerViewSupporting {
    
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var background: CustomDashedView!
    @IBOutlet weak var leadingInset: NSLayoutConstraint!
    @IBOutlet weak var trailingInset: NSLayoutConstraint!
    
    @IBOutlet weak var labelTop: NSLayoutConstraint!
    
    var heightInContainer: CGFloat = 7777
    var widthInContainer: CGFloat = 777
    
    var tapAction: (()->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromXib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupFromXib()
    }
    
    func customizeView() {
        self.isUserInteractionEnabled = true
    }
    
    func configure(with answer: String) {
        if answer == "" {
            self.labelTop.constant = 39
        } else {
            self.labelTop.constant = 19
        }
        self.answerLabel.text = answer
    }
    
    func removeDash() {
        self.dashWidth = 0
        self.dashLength = 0
        self.dashColor = .clear
    }
    
    func highlight() {
        background.backgroundColor = UIColor(red: 0.047, green: 0.4, blue: 1, alpha: 1)
        self.answerLabel.textColor = .white
    }
    
    func unhighlight() {
        background.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        self.answerLabel.textColor = .black
    }
    
    
}
