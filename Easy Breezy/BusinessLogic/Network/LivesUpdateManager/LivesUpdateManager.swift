//
//  LivesManager.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 27.02.2023.
//

import Foundation

class LivesUpdateManager {
    
    static let shared = LivesUpdateManager()
   // UserProfile.shared.numberOfLifes
    func updateLives() {
        let data = ["count": 2, "emptyAt": nil, "user": String(UserProfile.shared.userInfo.user.id)] as [String : Any]
        let parameters = ["data": data]
        let livesUpdateNetworkRepository = LivesUpdateNetworkRepository()
        livesUpdateNetworkRepository.registerAccount(livesInfo: parameters) { isSuccesful in
            if isSuccesful {
            }
        }
    }
    
}
