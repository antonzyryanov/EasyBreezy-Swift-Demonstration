//
//  LoginModel.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 29.12.2022.
//

import Foundation

struct LoginModel {
    var onBoardings: [OnBoardingItem]
}

enum OnBoardingItemType: String {
    case infoScreen
    case subscription
}

struct OnBoardingItem {
    var image: String
    var type: OnBoardingItemType = .infoScreen
    var text: String
}
