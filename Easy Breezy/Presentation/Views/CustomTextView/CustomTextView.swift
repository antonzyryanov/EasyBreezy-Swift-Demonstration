//
//  CustomTextView.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 03.01.2023.
//

import UIKit

class CustomTextView: UIView, XibLoadable {
    
    @IBOutlet weak var textView: UITextView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromXib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupFromXib()
    }
    
    func customizeView() {
        textView.textContainer.lineFragmentPadding = 0
    }
    
}
