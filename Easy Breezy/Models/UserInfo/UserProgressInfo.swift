//
//  UserProgressInfo.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 13.02.2023.
//

import Foundation

class UserProgressInfo {
    
    static let shared = UserProgressInfo()
    
    var coursesProgress: [String:Double] = [:]
    var coursesPasedExercises: [String:Int] = [:]
    
    func saveProgress() {
        UserDefaults.standard.set(coursesProgress, forKey: "courses_progress")
        UserDefaults.standard.set(coursesPasedExercises, forKey: "courses_pased_exercises")
    }
    
    func loadProgress() {
        if let coursesProgress = UserDefaults.standard.value(forKey: "courses_progress") as? [String:Double] {
            for key in coursesProgress.keys {
                self.coursesProgress.updateValue(coursesProgress[key] ?? 0, forKey: key)
            }
            NotificationCenter.default.post(Notification(name: .init("updateProgress")))
        }
        if let coursesPasedExercises = UserDefaults.standard.value(forKey: "courses_pased_exercises") as? [String:Int] {
            self.coursesPasedExercises = coursesPasedExercises
        }
    }
    
    func getProgressFor(course: String) -> Double? {
        for key in coursesProgress.keys {
            if key == course {
                return coursesProgress[course]
            }
        }
        return nil
    }
    
}
