//
//  TermsComparisonExerciseModel.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 10.12.2022.
//

import Foundation

struct TermsComparisonExerciseModel: ExerciseContent {
    var order: Int
    var title: String
    var commentary: String
    var terms: [String]
    var definitions: [String]
    var rightOrder: String
    var comments: [String]
    var themeName: String
    var contentItems: [ContainerItem]
}
