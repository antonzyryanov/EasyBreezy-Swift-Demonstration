//
//  RightOrderExerciseModel.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 10.12.2022.
//

import Foundation

struct RightOrderExerciseModel: ExerciseContent {
    var order: Int
    var title: String
    var commentary: String
    var steps: [String]
    var numberOfSteps: Int
    var rightOrder: String
    var comments: [String]
    var themeName: String
    var contentItems: [ContainerItem]
}
