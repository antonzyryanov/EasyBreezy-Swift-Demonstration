//
//  AnswersOptionsViewModel.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 28.04.2023.
//

import Foundation
import AffiseAttributionLib

class AnswersOptionsViewModel {
    
    func logCorrectAnswer() {
        EventTracker.shared.log(event: "correct_answer", with: ["course_name": ExercisesRouter.shared.currentCourseName, "theme_name": CurrentCourse.shared.currentTheme, "lesson_name": "\(CurrentCourse.shared.currentExerciseIndex)" ], and: ["username": UserProfile.shared.userInfo.user.username])
        Affise.shared.sendEvent(event: CustomId06Event(custom: "correct_answer", timeStampMillis: Int64(Date().timeIntervalSince1970 * 1000), userData: UserProfile.shared.userInfo.user.username).apply {
                            $0.addPredefinedParameter(parameter: .PARAM_01, value: ExercisesRouter.shared.currentCourseName)
                            $0.addPredefinedParameter(parameter: .PARAM_02, value: UserProfile.shared.userInfo.user.username)
                            $0.addPredefinedParameter(parameter: .PARAM_03, value: CurrentCourse.shared.currentTheme)
                            $0.addPredefinedParameter(parameter: .PARAM_04, value: "\(CurrentCourse.shared.currentExerciseIndex)")
                        })
    }
    
    func logWrongAnswer() {
        EventTracker.shared.log(event: "wrong_answer", with: ["course_name": ExercisesRouter.shared.currentCourseName, "theme_name": CurrentCourse.shared.currentTheme, "lesson_name": "\(CurrentCourse.shared.currentExerciseIndex)" ], and: ["username": UserProfile.shared.userInfo.user.username])
        Affise.shared.sendEvent(event: CustomId07Event(custom: "wrong_answer", timeStampMillis: Int64(Date().timeIntervalSince1970 * 1000), userData: UserProfile.shared.userInfo.user.username).apply {
                            $0.addPredefinedParameter(parameter: .PARAM_01, value: ExercisesRouter.shared.currentCourseName)
                            $0.addPredefinedParameter(parameter: .PARAM_02, value: UserProfile.shared.userInfo.user.username)
                            $0.addPredefinedParameter(parameter: .PARAM_03, value: CurrentCourse.shared.currentTheme)
                            $0.addPredefinedParameter(parameter: .PARAM_04, value: "\(CurrentCourse.shared.currentExerciseIndex)")
                        })
    }
    
}
