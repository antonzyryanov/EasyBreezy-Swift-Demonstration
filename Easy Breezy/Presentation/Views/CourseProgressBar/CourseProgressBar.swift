//
//  CourseProgressBar.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 04.12.2022.
//

import Foundation
import UIKit

class CourseProgressBar: UIView, XibLoadable {
    
    @IBOutlet weak var progressBarWidth: NSLayoutConstraint!
    @IBOutlet weak var backgroundBarWidth: NSLayoutConstraint!
    @IBOutlet weak var progressBar: RoundedCornersView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromXib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupFromXib()
    }
    
    func configure(with percentage: Double) {
       // self.progressBarWidth.constant = backgroundBarWidth.constant*(percentage/100)
        if percentage == 0 {
            self.progressBar.isHidden = true
        } else {
            self.progressBar.isHidden = false
            self.progressBarWidth = self.progressBarWidth.setMultiplier(multiplier: percentage/100)
        }
        self.layoutIfNeeded()
    }
    
}
