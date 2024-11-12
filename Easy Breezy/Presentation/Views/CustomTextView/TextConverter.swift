//
//  TextConverter.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 25.03.2023.
//

import Foundation

class TextConverter {
    
    static let shared = TextConverter()
    
    fileprivate func setComponentTextType(_ index: Int, _ customTextStrings: inout [CustomTextString], _ component: String) {
        if index % 2 != 0 {
            customTextStrings.append(CustomTextString(string: component, type: .bold))
        } else {
            customTextStrings.append(CustomTextString(string: component, type: .normal))
        }
    }
    
    func createCustomTextStringsfrom(text: String) -> [CustomTextString] {
        if text.components(separatedBy: "**").count == 0 {
            return [CustomTextString(string: text, type: .normal)]
        }
        var customTextStrings: [CustomTextString] = []
        let textComponents = text.components(separatedBy: "**")
        for (index,component) in textComponents.enumerated() {
            setComponentTextType(index, &customTextStrings, component)
        }
        return customTextStrings
    }
    
}
