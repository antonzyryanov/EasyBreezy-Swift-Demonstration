//
//  CurrentCourse.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 06.12.2022.
//

import Foundation

class CurrentCourse {
    
    static var shared = FakeModelGenerator.shared.generateFakeCurrentCourse()
    
    var exercises: [Exercise] = []
    var nextExerciseIndex: Int = 0
    var currentTheme: String = ""
    
    var currentExerciseIndex: Int {
        return nextExerciseIndex - 1
    }
    
    var nextExerciseContent: ExerciseContent {
        return exercises[nextExerciseIndex].content
    }
    var nextExerciseType: ExerciseType {
        return exercises[nextExerciseIndex].type
    }
    
    var currentExerciseContent: ExerciseContent {
        return exercises[currentExerciseIndex].content
    }
    var currentExerciseType: ExerciseType {
        return exercises[currentExerciseIndex].type
    }
    
    var completionPercent: Double {
        return Double(100*nextExerciseIndex/exercises.count)
    }
    
    init(exercises: [Exercise]) {
        self.exercises = exercises
    }
    
    func configureWith(exercises: [Exercise]) {
        self.exercises = exercises
        nextExerciseIndex = 0
    }
    
}
