//
//  TwoColumnsExerciseModel.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 10.12.2022.
//

import Foundation

struct TwoColumnsExerciseModel: ExerciseContent {
    var order: Int
    var title: String
    var commentary: String
    var steps: [String]
    var firstColumnRightOrder: String
    var secondColumnRightOrder: String
    var firstColumnName: String
    var secondColumnName: String
    var comments: [String]
    var themeName: String
    var contentItems: [ContainerItem]
}
