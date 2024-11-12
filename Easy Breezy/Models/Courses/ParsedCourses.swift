//
//  ParsedCourse.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 28.01.2023.
//

import Foundation

// MARK: - Course
struct ParsedCourses: Codable {
    let data: [CourseData]
    let meta: CourseMeta
}

// MARK: - Datum
struct CourseData: Codable {
    let id: Int
    let attributes: Attributes
}

// MARK: - Attributes
struct Attributes: Codable {
    let locale: String
    let content: String?
    let order: Int
    let title, publishedAt: String
    let durationMin: Int
    let description, createdAt, name, updatedAt: String
}

// MARK: - Meta
struct CourseMeta: Codable {
    let pagination: Pagination
}

// MARK: - Pagination
struct Pagination: Codable {
    let pageCount, pageSize, total, page: Int
}
