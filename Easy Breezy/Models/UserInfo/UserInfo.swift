//
//  UserInfo.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 28.01.2023.
//

import Foundation

struct UserInfo: Codable {
    let user: User
    let jwt: String
}

struct User: Codable {
    let id: Int
    let username, email: String
}
