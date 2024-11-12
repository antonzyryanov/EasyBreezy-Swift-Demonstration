//
//  EnumeratedAnswerOptionVIew.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 08.12.2022.
//

import UIKit

class EnumeratedAnswerOptionView: CustomDashedView, XibLoadable, ContainerViewSupporting {
    
    @IBOutlet weak var letterLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet var background: RoundedCornersView!
    
    @IBOutlet weak var letterWidth: NSLayoutConstraint!
    @IBOutlet weak var letterRightConstraint: NSLayoutConstraint!
    
    var heightInContainer: CGFloat = 777
    
    var tapAction: (()->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromXib()
     //   setBorder()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupFromXib()
     //   setBorder()
    }
    
    func customizeView() {
       // setBorder()
    }
    
    func configure(with answer: String, and letter: String) {
        self.letterLabel.text = letter
        self.answerLabel.text = answer
    }
    
    private func setBorder() {
        var border = CAShapeLayer()
        border.strokeColor = UIColor.black.cgColor
        border.lineDashPattern = [2, 2]
        border.frame = self.bounds
        border.fillColor = nil
        border.path = UIBezierPath(rect: self.bounds).cgPath
        self.layer.addSublayer(border)
    }
    
    func highlight() {
        background.backgroundColor = UIColor(red: 0.047, green: 0.4, blue: 1, alpha: 1)
        self.letterLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        self.answerLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    func unhighlight() {
        background.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        self.letterLabel.textColor = UIColor(red: 0.275, green: 0.286, blue: 0.314, alpha: 1)
        self.answerLabel.textColor = UIColor(red: 0.275, green: 0.286, blue: 0.314, alpha: 1)
    }
    
    @IBAction func tapAction(_ sender: Any) {
        tapAction?()
    }
    
}
