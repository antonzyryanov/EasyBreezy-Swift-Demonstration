//
//  Course.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 03.12.2022.
//

import Foundation

struct Course {
    var title: String
    var image: String
    var completionPercentage: Double
    var courseData: CourseData = CourseData(id: 0, attributes: .init(locale: "", content: "", order: 0, title: "", publishedAt: "", durationMin: 0, description: "", createdAt: "", name: "", updatedAt: ""))
}
