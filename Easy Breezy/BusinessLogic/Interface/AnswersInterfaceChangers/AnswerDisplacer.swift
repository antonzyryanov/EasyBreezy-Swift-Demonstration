//
//  AnswerDisplacer.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 12.03.2023.
//

import Foundation

class AnswerDisplacer {
    
    static let shared = AnswerDisplacer()
    
    var stepsViewModels: [FunnelStepViewModel] = []
    
    func configure(with stepsViewModels: [FunnelStepViewModel] ) {
        self.stepsViewModels = stepsViewModels
    }
    
    func displaceToLeftAnswers(chosenStepIndex: Int) {
        hideLastVisibleStep()
        displaceAnswersToLeftBeginingFrom(chosenStepIndex: chosenStepIndex)
    }
    
    func makeAnswerThatNeedsToBeReturnedFirstHidden(answerIndex: Int) {
        guard let firstViewModelWithHiddenViewIndex = stepsViewModels.firstIndex(where: { $0.view.isHidden == true }) else { return }
        guard let answerThatNeedsToBeReturnedViewModelIndex = stepsViewModels.firstIndex(where: { $0.index == answerIndex }) else { return }
        swapTwoViewModelsInfoWith(firstIndex: firstViewModelWithHiddenViewIndex, secondIndex: answerThatNeedsToBeReturnedViewModelIndex)
    }
    
    private func hideLastVisibleStep() {
        guard let lastVisibleStep = stepsViewModels.last(where: {$0.view.isHidden == false}) else { return }
        lastVisibleStep.view.isHidden = true
    }
    
    private func displaceAnswersToLeftBeginingFrom(chosenStepIndex: Int) {
        if chosenStepIndex - 1 == stepsViewModels.count { return }
        for index in chosenStepIndex..<stepsViewModels.count - 1 {
            swapTwoViewModelsInfoWith(firstIndex: index, secondIndex: index+1)
        }
    }
    
    private func swapTwoViewModelsInfoWith(firstIndex: Int, secondIndex: Int) {
        let firstViewModelIndex = stepsViewModels[firstIndex].index
        let firstAnswer = stepsViewModels[firstIndex].view.answerLabel.text ?? ""
        stepsViewModels[firstIndex].index = stepsViewModels[secondIndex].index
        stepsViewModels[firstIndex].view.answerLabel.text = stepsViewModels[secondIndex].view.answerLabel.text
        stepsViewModels[secondIndex].index = firstViewModelIndex
        stepsViewModels[secondIndex].view.answerLabel.text = firstAnswer
    }
    
}
