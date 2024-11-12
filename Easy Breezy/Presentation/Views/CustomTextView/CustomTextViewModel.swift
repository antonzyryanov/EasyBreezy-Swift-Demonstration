//
//  CustomTextViewModel.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 03.01.2023.
//

import Foundation
import UIKit

class CustomTextViewModel {
    
    var view: CustomTextView!
    var model: CustomTextModel!
    
    init(view: CustomTextView, model: CustomTextModel) {
        self.view = view
        self.model = model
        self.view.textView.textContainer.lineBreakMode = .byWordWrapping
        configure()
    }
    
    func configure() {
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 6
        let attributes = [NSAttributedString.Key.paragraphStyle : style]
        
        var finalString: NSMutableAttributedString = NSMutableAttributedString(attributedString: NSAttributedString(string: ""))
        
        for customString in model.customTextStrings {
            var attributedString = NSMutableAttributedString(string: customString.string)
            if customString.type == .bold {
                attributedString.setAttributes([.font: UIFont(name: "Inter-Bold", size: model.fontSize),.paragraphStyle: style], range: NSMakeRange(0, attributedString.string.count))
            } else {
                attributedString.setAttributes([.font: UIFont(name: "Inter-Medium", size: model.fontSize),.paragraphStyle: style], range: NSMakeRange(0, attributedString.string.count))
            }
            finalString.append(attributedString)
        }
        
        self.view.textView.attributedText = finalString
        self.view.textView.isUserInteractionEnabled = true
        self.view.textView.isEditable = false
    }
    
}
