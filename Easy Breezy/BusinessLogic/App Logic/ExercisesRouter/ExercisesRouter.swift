//
//  ExercisesRouter.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 07.12.2022.
//

import Foundation
import UIKit
import Appodeal
import AffiseAttributionLib

class ExercisesRouter {
    
    static let shared = ExercisesRouter()
    
    var currentCourseName: String = ""
    
    var isUserPassingExercises: Bool = true
    
    func showNextExerciseIn(viewController: UIViewController) {
        if CurrentCourse.shared.nextExerciseIndex == CurrentCourse.shared.exercises.count {
            EventTracker.shared.log(event: "course_finished", with: ["course_name":currentCourseName], and: ["username":UserProfile.shared.userInfo.user.username])
            Affise.shared.sendEvent(event: CustomId02Event(custom: "course_finished", timeStampMillis: Int64(Date().timeIntervalSince1970 * 1000), userData: UserProfile.shared.userInfo.user.username).apply {
                $0.addPredefinedParameter(parameter: .PARAM_01, value: currentCourseName)
                $0.addPredefinedParameter(parameter: .PARAM_02, value: UserProfile.shared.userInfo.user.username)
            })
            
            let nc = NotificationCenter.default
            nc.post(name: Notification.Name("coursePassed"), object: nil)
            viewController.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
            return
        }
        
        trackCourseStartIfNeeded()
        
        var exerciseToShowType: ExerciseType = .courseEnd
        var exerciseContent: ExerciseContent = InformationModel(order: 0, theme: "", informationItems: [], themeName: "")
        
        if isUserPassingExercises {
            exerciseToShowType = CurrentCourse.shared.nextExerciseType
            exerciseContent = CurrentCourse.shared.nextExerciseContent
        } else {
            exerciseToShowType = CurrentCourse.shared.currentExerciseType
            exerciseContent = CurrentCourse.shared.currentExerciseContent
        }
        
        switch exerciseToShowType {
        case .information:
            guard let informationModel = exerciseContent as? InformationModel else { return }
            checkIfNewCourseThemeBegan(newTheme: informationModel.themeName)
            let storyboard = UIStoryboard(name: "InformationViewController", bundle: nil)
            guard let vc = storyboard.instantiateViewController(withIdentifier: "InformationViewController") as? InformationViewController else { return }
            vc.modalPresentationStyle = .fullScreen
            vc.model = informationModel
            viewController.present(vc, animated: true)
        case .singleOptionChoise:
            guard let singleOptionChoiseModel = exerciseContent as? SingleOptionChoiseModel else { return }
            checkIfNewCourseThemeBegan(newTheme: singleOptionChoiseModel.themeName)
            let storyboard = UIStoryboard(name: "SingleOptionChoiseViewController", bundle: nil)
            guard let vc = storyboard.instantiateViewController(withIdentifier: "SingleOptionChoiseViewController") as? SingleOptionChoiseViewController else { return }
            vc.modalPresentationStyle = .fullScreen
            vc.model = singleOptionChoiseModel
            viewController.present(vc, animated: true)
        case .multipleOptionsChoise:
            guard let multipleOptionChoiseModel = exerciseContent as? MultipleOptionChoiseModel else { return }
            checkIfNewCourseThemeBegan(newTheme: multipleOptionChoiseModel.themeName)
            let storyboard = UIStoryboard(name: "MultipleOptionChoiseViewController", bundle: nil)
            guard let vc = storyboard.instantiateViewController(withIdentifier: "MultipleOptionChoiseViewController") as? MultipleOptionChoiseViewController else { return }
            vc.modalPresentationStyle = .fullScreen
            vc.model = multipleOptionChoiseModel
            viewController.present(vc, animated: true)
        case .pyramid:
            guard let funnelExerciseModel = exerciseContent as? FunnelExerciseModel else { return }
            checkIfNewCourseThemeBegan(newTheme: funnelExerciseModel.themeName)
            let storyboard = UIStoryboard(name: "FunnelExerciseViewController", bundle: nil)
            guard let vc = storyboard.instantiateViewController(withIdentifier: "FunnelExerciseViewController") as? FunnelExerciseViewController else { return }
            vc.modalPresentationStyle = .fullScreen
            vc.model = funnelExerciseModel
            viewController.present(vc, animated: true)
        case .termsComparison:
            guard let termsComparisonExerciseModel = exerciseContent as? TermsComparisonExerciseModel else { return }
            checkIfNewCourseThemeBegan(newTheme: termsComparisonExerciseModel.themeName)
            let storyboard = UIStoryboard(name: "TermsComparisonViewController", bundle: nil)
            guard let vc = storyboard.instantiateViewController(withIdentifier: "TermsComparisonViewController") as? TermsComparisonExerciseViewController else { return }
            vc.modalPresentationStyle = .fullScreen
            vc.model = termsComparisonExerciseModel
            viewController.present(vc, animated: true)
        case .missedWord:
            guard let missedWordExerciseModel = exerciseContent as? MissedWordExerciseModel else { return }
            checkIfNewCourseThemeBegan(newTheme: missedWordExerciseModel.themeName)
            let storyboard = UIStoryboard(name: "MissedWordExerciseViewController", bundle: nil)
            guard let vc = storyboard.instantiateViewController(withIdentifier: "MissedWordExerciseViewController") as? MissedWordExerciseViewController else { return }
            vc.modalPresentationStyle = .fullScreen
            vc.model = missedWordExerciseModel
            viewController.present(vc, animated: true)
        case .rightOrder:
            guard let rightOrderExerciseModel = exerciseContent as? RightOrderExerciseModel else { return }
            checkIfNewCourseThemeBegan(newTheme: rightOrderExerciseModel.themeName)
            let storyboard = UIStoryboard(name: "RightOrderExerciseViewController", bundle: nil)
            guard let vc = storyboard.instantiateViewController(withIdentifier: "RightOrderExerciseViewController") as? RightOrderExerciseViewController else { return }
            vc.modalPresentationStyle = .fullScreen
            vc.model = rightOrderExerciseModel
            viewController.present(vc, animated: true)
        case .twoColumns:
            guard let twoColumnsExerciseModel = exerciseContent as? TwoColumnsExerciseModel else { return }
            checkIfNewCourseThemeBegan(newTheme: twoColumnsExerciseModel.themeName)
            let storyboard = UIStoryboard(name: "TwoColumnsExerciseViewController", bundle: nil)
            guard let vc = storyboard.instantiateViewController(withIdentifier: "TwoColumnsExerciseViewController") as? TwoColumnsExerciseViewController else { return }
            vc.modalPresentationStyle = .fullScreen
            vc.model = twoColumnsExerciseModel
            viewController.present(vc, animated: true)
        case .courseEnd:
//            guard let courseEndModel = exerciseContent as? CourseEndModel else { return }
            let storyboard = UIStoryboard(name: "CourseCompletedViewController", bundle: nil)
            guard let vc = storyboard.instantiateViewController(withIdentifier: "CourseCompletedViewController") as? CourseCompletedViewController else { return }
            vc.modalPresentationStyle = .fullScreen
            vc.currentCourseName = currentCourseName
            viewController.present(vc, animated: true)
        }
        if isUserPassingExercises {
            CurrentCourse.shared.nextExerciseIndex += 1
        }
        UserProgressInfo.shared.coursesProgress.updateValue((Double(CurrentCourse.shared.nextExerciseIndex)/Double(CurrentCourse.shared.exercises.count))*100, forKey: currentCourseName)
        UserProgressInfo.shared.coursesPasedExercises.updateValue(CurrentCourse.shared.nextExerciseIndex, forKey: currentCourseName)
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("updateProgress"), object: nil)
    }
    
    private func trackCourseStartIfNeeded() {
        if CurrentCourse.shared.nextExerciseIndex == 1 {
            EventTracker.shared.log(event: "course_started", with: ["course_name": currentCourseName ], and: ["username": UserProfile.shared.userInfo.user.username])
            Affise.shared.sendEvent(event: CustomId01Event(custom: "course_started", timeStampMillis: Int64(Date().timeIntervalSince1970 * 1000), userData: UserProfile.shared.userInfo.user.username).apply {
                $0.addPredefinedParameter(parameter: .PARAM_01, value: currentCourseName)
                $0.addPredefinedParameter(parameter: .PARAM_02, value: UserProfile.shared.userInfo.user.username)
            })
        }
    }
    
    private func checkIfNewCourseThemeBegan(newTheme: String) {
//        if CurrentCourse.shared.currentTheme != newTheme {
//            if newTheme != "" {
//                EventTracker.shared.log(event: "theme_started", with: ["course_name": currentCourseName, "theme_name": newTheme ], and: ["username": UserProfile.shared.userInfo.user.username])
//                Affise.shared.sendEvent(event: CustomId03Event(custom: "theme_started", timeStampMillis: Int64(Date().timeIntervalSince1970 * 1000), userData: UserProfile.shared.userInfo.user.username).apply {
//                    $0.addPredefinedParameter(parameter: .PARAM_01, value: currentCourseName)
//                    $0.addPredefinedParameter(parameter: .PARAM_02, value: UserProfile.shared.userInfo.user.username)
//                    $0.addPredefinedParameter(parameter: .PARAM_03, value: newTheme)
//                })
//            }
//            if CurrentCourse.shared.currentTheme != "" {
//                EventTracker.shared.log(event: "theme_finished", with: ["course_name": currentCourseName, "theme_name": CurrentCourse.shared.currentTheme ], and: ["username": UserProfile.shared.userInfo.user.username])
//                Affise.shared.sendEvent(event: CustomId04Event(custom: "theme_finished", timeStampMillis: Int64(Date().timeIntervalSince1970 * 1000), userData: UserProfile.shared.userInfo.user.username).apply {
//                    $0.addPredefinedParameter(parameter: .PARAM_01, value: currentCourseName)
//                    $0.addPredefinedParameter(parameter: .PARAM_02, value: UserProfile.shared.userInfo.user.username)
//                    $0.addPredefinedParameter(parameter: .PARAM_03, value: newTheme)
//                })
//                AdvertisementManager.shared.advertisementNeedsToBeShown = true
//            }
//            CurrentCourse.shared.currentTheme = newTheme
//        }
    }
    
}
