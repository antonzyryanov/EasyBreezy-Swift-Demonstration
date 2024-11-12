//
//  OnBoardingQuestionsModel.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 02.08.2023.
//

import Foundation

struct OnBoardingQuestionsModel {
    var questions: [OnBoardingQuestionModel]
}

struct OnBoardingQuestionModel {
    var question: String
    var bigEmoji: String
    var answers: [OnboardingAnswerModel]
}
