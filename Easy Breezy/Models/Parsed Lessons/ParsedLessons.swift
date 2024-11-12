//
//  ParsedLessons.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 29.01.2023.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct ParsedCourse: Codable {
    let meta: Meta
    let data: ParsedCourseData
}

// MARK: - DataClass
struct ParsedCourseData: Codable {
    let id: Int
    let attributes: ParsedCourseAttributes
}

// MARK: - DataAttributes
struct ParsedCourseAttributes: Codable {
    let locale: Locale
    let content: String?
    let order: Int
    let title, publishedAt: String
    let lessons: Lessons
    let durationMin: Int
    let description, createdAt, name, updatedAt: String
}

// MARK: - Lessons
struct Lessons: Codable {
    let data: [LessonData]
}

// MARK: - Datum
struct LessonData: Codable {
    let id: Int
    let attributes: LessonAttributes
}

// MARK: - DatumAttributes
struct LessonAttributes: Codable {
    let locale: Locale
    let content: String?
    let order: Int
    let trainerLabel: String?
    let title: String
    let trainerType: String?
    let publishedAt, updatedAt, createdAt, name: String
    let trainer: Trainer?
}

enum Locale: String, Codable {
    case en = "en"
}

// MARK: - Trainer
struct Trainer: Codable {
    let answer: [String]?
    let options: [Option]
    let success: String
    let answers: [String]?
    let error: String?
    let firstColumnName: String?
    let secondColumnName: String?
    
    enum CodingKeys: String, CodingKey {
      case answer, options, success, answers, error
      case firstColumnName = "first_column_name"
      case secondColumnName = "second_column_name"
    }
    
}

// MARK: - Option
struct Option: Codable {
    let error: String?
    let title, value: String
}

// MARK: - Meta
struct Meta: Codable {
}
