//
//  OnboardingProgressItemView.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 02.08.2023.
//

import Foundation
import UIKit

class OnboardingProgressItemView: UIView, XibLoadable, HorisontalContainerViewSupporting {
    
    @IBOutlet weak var progressBar: RoundedCornersView!
    
    var widthInContainer: CGFloat = 78
    
    var isPageShown: Bool = false {
        didSet {
            if isPageShown {
                self.progressBar.backgroundColor = UIColor(red: 56/255, green: 161/255, blue: 255/255, alpha: 1)
            } else {
                self.progressBar.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
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
    
}
