//
//  FunnelStepViewModel.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 09.12.2022.
//

import Foundation
import UIKit

class FunnelStepViewModel {
    
    var view: FunnelStepView!
    var index: Int = 777
    var isSelected: Bool = false
    var isDragging: Bool = false
    var selectAction: ((Int)->Void)?
    var initialOrigin: (CGFloat,CGFloat)?
    var definition: String = ""
    
    init(view: FunnelStepView) {
        self.view = view
    }
    
    func configureWith(answer: String, index: Int, isDraggable: Bool = false, isDefinition: Bool = false) {
        self.view.tapAction = tapAction
        self.index = index
        if isDefinition {
            let definition = "- " + answer
            self.view.configure(with: definition)
            self.definition = definition
            return
        }
        self.view.configure(with: answer)
    }
    
    func configureWithDefinition() {
        self.view.configure(with: definition)
    }
    
    func configureWith(term: String) {
        self.view.configure(with: term + " " + definition)
    }
    
    func tapAction() {
        selectAction?(index)
    }
    
}
