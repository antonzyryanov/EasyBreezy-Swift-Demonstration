//
//  InformationModel.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 06.12.2022.
//

import Foundation

struct InformationModel: ExerciseContent {
    var order: Int
    var theme: String
    var informationItems: [ContainerItem]
    var themeName: String
}
