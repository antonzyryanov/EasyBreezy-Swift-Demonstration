//
//  MissedWordModel.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 03.01.2023.
//

import Foundation

struct MissedWordModel {
    var missedWordStrings: [MissedWordString]
}

struct MissedWordString {
    var string: String
    var type: MissedWordStringType
}

enum MissedWordStringType {
    case text
    case missedWord
}

struct ChosenMissedWord {
    var string: String
    var index: Int
}
