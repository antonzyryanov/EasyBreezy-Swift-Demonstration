//
//  ProgressManager.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 28.02.2023.
//

import Foundation

class ProgressUpdateManager {
    
    static let shared = ProgressUpdateManager()
    
    func updateProgress() {
        let data = ["id": "\(UserProfile.shared.userInfo.user.id)", "exercisesPassed": 112] as [String : Any] //exercisesPassed
        let parameters = ["data": data]
        let progressUpdateNetworkRepository = ProgressesUpdateNetworkRepository()
        progressUpdateNetworkRepository.saveProgress(progressInfo: parameters) { isSuccesful in
            if isSuccesful {
            }
        }
    }
    
}
