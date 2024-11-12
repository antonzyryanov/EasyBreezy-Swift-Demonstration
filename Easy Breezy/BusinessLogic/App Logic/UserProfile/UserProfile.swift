//
//  UserProfile.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 28.01.2023.
//

import Foundation

class UserProfile {
    
    static let shared = UserProfile(userInfo: UserInfo(user: User(id: 9, username: "", email: ""), jwt: ""))
    
    var userInfo: UserInfo
    
    var numberOfLifes: Int = 3 {
        didSet {
            self.numberOfLifes = 3
        }
    }
    
    var livesRanOutDate: String? = nil
    
    init(userInfo: UserInfo) {
        self.userInfo = userInfo
    }
    
}


