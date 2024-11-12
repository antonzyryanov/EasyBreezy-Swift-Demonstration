//
//  LanguageSelectionView.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 23.08.2023.
//

import Foundation
import UIKit

class LanguageSelectionView: UIView, XibLoadable {
    
    @IBOutlet weak var languagesContainerView: ContainerView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromXib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupFromXib()
    }
    
    
    
}
