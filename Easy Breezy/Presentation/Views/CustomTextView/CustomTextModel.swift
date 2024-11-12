//
//  CustomTextModel.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 03.01.2023.
//

import Foundation

class CustomTextModel {
    var customTextStrings: [CustomTextString]
    var fontSize: CGFloat = 16
    init(from text: String, with fontSize: CGFloat = 16) {
        self.customTextStrings = TextConverter.shared.createCustomTextStringsfrom(text: text)
        self.fontSize = fontSize
    }
    
}

struct CustomTextString {
    var string: String
    var type: CustomTextStringType
}

enum CustomTextStringType {
    case normal
    case bold
}
