//
//  OnboardingCourseDescriptionItem.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 25.08.2023.
//

import Foundation
import UIKit

class OnboardingCourseDescriptionItem: UIView, XibLoadable, ContainerViewSupporting {
    
    var heightInContainer: CGFloat = 777
    
    @IBOutlet weak var courseImage: UIImageView!
    @IBOutlet weak var courseName: UILabel!
    @IBOutlet weak var themesContainerView: ContainerView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromXib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupFromXib()
    }
    
}
