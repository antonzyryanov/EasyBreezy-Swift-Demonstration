//
//  EnumeratedAnswerOptionVIewModel.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 09.12.2022.
//

import Foundation

class EnumeratedAnswerOptionViewModel {
    
    var view: EnumeratedAnswerOptionView!
    var index: Int = 0
    var isSelected: Bool = false
    var selectAction: ((Int)->Void)?
    
    init(view: EnumeratedAnswerOptionView) {
        self.view = view
    }
    
    func configureWith(answer: String, index: Int) {
        let letter = Letter.forIndex[index]
        self.view.configure(with: answer, and: letter)
        self.view.tapAction = tapAction
        self.index = index
    }
    
    func tapAction() {
        selectAction?(index)
    }
    
}
