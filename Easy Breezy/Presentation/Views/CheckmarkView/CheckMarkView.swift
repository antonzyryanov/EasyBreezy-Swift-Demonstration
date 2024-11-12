//
//  CheckMarkView.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 04.12.2022.
//

import Foundation
import UIKit

class CheckmarkView: UIView, XibLoadable, ContainerViewSupporting {
    
    var heightInContainer: CGFloat = 80
    
    @IBOutlet weak var progressBar: CourseProgressBar!
    @IBOutlet weak var itemLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromXib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupFromXib()
    }
    
    func configure(with label: String) {
        self.itemLabel.text = label
        self.progressBar.configure(with: 25)
    }
    
}
