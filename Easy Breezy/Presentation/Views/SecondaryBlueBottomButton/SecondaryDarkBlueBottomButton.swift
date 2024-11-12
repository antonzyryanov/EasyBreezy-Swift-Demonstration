//
//  SecondaryDarkBlueBottomButton.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 04.12.2022.
//

import UIKit

@IBDesignable
class SecondaryDarkBlueBottomButton: UIView, XibLoadable {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var roundedCornersView: RoundedCornersView!
    
    var tapAction: (()->Void)?
    
    @IBInspectable var title: String = "" {
        didSet {
            self.titleLabel.text = title
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
       // addShadow()
    }
    
    private func addShadow() {
        roundedCornersView.shadowRadius = 3
    }
    
    @IBAction func tapAction(_ sender: Any) {
        tapAction?()
    }
    
}
