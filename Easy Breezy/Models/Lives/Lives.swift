//
//  Lives.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 27.02.2023.
//

import Foundation

// MARK: - Welcome
struct Lives: Codable {
    let data: [LivesData]
    let meta: LivesMeta
}

// MARK: - Datum
struct LivesData: Codable {
    let id: Int
    let attributes: LivesAttributes
}

// MARK: - Attributes
struct LivesAttributes: Codable {
    var emptyAt: String?
    var count: Int
    let updatedAt, createdAt: String
}

// MARK: - Meta
struct LivesMeta: Codable {
    let pagination: Pagination
}
