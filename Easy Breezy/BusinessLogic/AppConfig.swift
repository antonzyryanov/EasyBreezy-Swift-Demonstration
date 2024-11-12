//
//  AppConfig.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 20.09.2023.
//

import Foundation

class AppConfig {
    
    static let shared = AppConfig()
    
    var httpsMode: Bool = true {
        didSet {
            if httpsMode {
                Constants.API.apiProtocol = "https://"
            } else {
                Constants.API.apiProtocol = "http://"
            }
        }
    }
    
}
