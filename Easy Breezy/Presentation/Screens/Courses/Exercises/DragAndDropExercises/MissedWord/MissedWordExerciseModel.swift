//
//  MissedWordExerciseModel.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 10.12.2022.
//

import Foundation

struct MissedWordExerciseModel: ExerciseContent {
    var order: Int
    var title: String
    var commentary: String
    var text: MissedWordModel
    var words: [String]
    var rightOrder: String
    var comments: [String]
    var themeName: String
    var contentItems: [ContainerItem]
}
