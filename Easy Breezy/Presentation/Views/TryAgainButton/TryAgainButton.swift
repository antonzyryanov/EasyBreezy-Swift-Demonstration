//
//  TryAgainButton.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 13.01.2023.
//

import UIKit

class TryAgainButton: UIView, XibLoadable {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var refreshSign: UIImageView!
    @IBOutlet weak var commentaryArrow: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var tapAction: (()->Void)?
    
    var isExercisePassed: Bool = false {
        didSet {
            if isExercisePassed {
                self.refreshSign.isHidden = true
                self.commentaryArrow.isHidden = false
                self.label.text = "Next"
            } else {
                self.refreshSign.isHidden = false
                self.commentaryArrow.isHidden = true
                self.label.text = "Try again"
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
    
    @IBAction func tapAction(_ sender: UIButton) {
        tapAction?()
    }
    
    func customizeView() {
        button.setTitle("", for: .normal)
    }
    
}
