//
//  CourseLockedNotificationView.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 14.11.2023.
//

import UIKit

class CourseLockedNotificationView: UIView, XibLoadable {
    
    var tapAction: (()->Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromXib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupFromXib()
    }
    
    
    @IBAction func closeButton(_ sender: Any) {
        tapAction?()
    }
    
}
