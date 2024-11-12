//
//  ContainerItem.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 06.12.2022.
//

import Foundation

struct ContainerItem {
    
    enum ContentType: String {
        case text
        case image
    }
    
    var contentType: ContentType = .text
    var content: String
    
}
