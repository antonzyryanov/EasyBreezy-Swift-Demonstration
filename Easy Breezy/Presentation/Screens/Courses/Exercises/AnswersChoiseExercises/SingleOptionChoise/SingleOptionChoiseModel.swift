//
//  SingleOptionChoiseModel.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 08.12.2022.
//

import Foundation

struct SingleOptionChoiseModel: ExerciseContent {
    var order: Int
    var answerOptions: [String]
    var title: String
    var question: String
    var commentary: String
    var rightAnswer: Int
    var comments: [String]
    var themeName: String
}
