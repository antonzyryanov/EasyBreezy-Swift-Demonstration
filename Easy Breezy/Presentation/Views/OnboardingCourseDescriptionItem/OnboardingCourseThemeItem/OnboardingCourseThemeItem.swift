//
//  OnboardingCourseThemeItem.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 25.08.2023.
//

import Foundation
import UIKit

class OnboardingCourseThemeItem: UIView, XibLoadable, ContainerViewSupporting {
    
    var heightInContainer: CGFloat = 777
    
    @IBOutlet weak var courseNumber: UILabel!
    @IBOutlet weak var themeName: UILabel!
    
    @IBOutlet weak var lessonsQuantity: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromXib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupFromXib()
    }
    
    func configureWith(model: OnboardingCourseThemeItemModel) {
        self.courseNumber.text = model.couseNumber
        self.themeName.text = model.themeName
        self.lessonsQuantity.text = model.lessonsQuantity
    }
    
}
