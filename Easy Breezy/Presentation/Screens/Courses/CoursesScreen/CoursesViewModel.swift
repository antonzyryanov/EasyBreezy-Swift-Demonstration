//
//  CoursesViewModel.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 03.12.2022.
//

import Foundation
import UIKit
import Appodeal

class CoursesViewModel {
    
    var view: CoursesView!
    var model: CoursesModel!
    var exerciseTopViewModel: ExerciseTopViewModel!
    
    init(model: CoursesModel, view: CoursesView) {
        self.model = model
        self.view = view
        configure()
    }
    
    fileprivate func checkPreviousCourseCompletion(_ index: Int, _ completionPercentage: inout Double) {
        if let percentage = UserProgressInfo.shared.getProgressFor(course: model.courses[index-1].title) {
            completionPercentage = percentage
        } else {
            completionPercentage = model.courses[index-1].completionPercentage
        }
    }
    
    private func configure() {
        var views: [ContainerViewSupporting] = []
        for (index,course) in model.courses.enumerated() {
            let courseView = CourseView(frame: .zero)
                        if index > 0 {
                            var completionPercentage: Double = 0
                            checkPreviousCourseCompletion(index, &completionPercentage)
                            if index > 0 && completionPercentage != 100 {
                                courseView.isDisabled = true
                            }
                        }
            courseView.configure(with: course)
            courseView.tapAction = {
                
                guard let presentingViewController = self.view.viewController else { return }
                ExercisesRouter.shared.showNextExerciseIn(viewController: presentingViewController)
                return
                //
                
                guard let presentingViewController = self.view.viewController as? CoursesViewController else { return }
                
                if courseView.isDisabled {
                    presentingViewController.showCourseLockedNotification()
                    return
                }
                
                let coursesNetworkRepository = CoursesNetworkRepository()
                if UserProfile.shared.numberOfLifes == 0 {
                    self.presentNoLifesAlert()
                    return
                }
                coursesNetworkRepository.getCourse(with: self.model.courses[index].courseData.id) { isSuccessful in
                    if isSuccessful {
                        let openingCourseName = self.model.courses[index].courseData.attributes.title
                        
                        let openingCourseProgress = UserProgressInfo.shared.coursesPasedExercises[openingCourseName] ?? 0
                        ExercisesRouter.shared.currentCourseName = openingCourseName
                        if openingCourseProgress > 0 {
                            CurrentCourse.shared.nextExerciseIndex = openingCourseProgress
                            ExercisesRouter.shared.isUserPassingExercises = false
                            ExercisesRouter.shared.showNextExerciseIn(viewController: presentingViewController)
                            ExercisesRouter.shared.isUserPassingExercises = true
                            return
                        }
                        
                        guard let presentingViewController = self.view.viewController else { return }
                        ExercisesRouter.shared.showNextExerciseIn(viewController: presentingViewController)
                        
//                        let storyboard = UIStoryboard(name: "CourseIntroViewController", bundle: nil)
//                        guard let vc = storyboard.instantiateViewController(withIdentifier: "CourseIntroViewController") as? CourseIntroViewController else { return }
//                        vc.modalPresentationStyle = .fullScreen
//                        let introItemsString: String = self.model.courses[index].courseData.attributes.content ?? ""
//                        let introItems: [String] = introItemsString.components(separatedBy: ";\n\n")
//                        vc.model = CourseIntroModel(id: self.model.courses[index].courseData.id, name: self.model.courses[index].title, description: self.model.courses[index].courseData.attributes.description, items: introItems)
//                        presentingViewController.present(vc, animated: true)
                    } else {
                        
                    }
                }
                
            }
            views.append(courseView)
        }
        let containerModel = ContainerModel(views: views, settings: ContainerModel.Settings(leadingOffset: 0, trailingOffset: 0, topOffset: 0, bottomOffset: 0, componentsOffset: 16), priorities: ContainerModel.Priorities.init(componentHeight: 1000))
        view.containerView.clear()
        view.containerView.configure(with: containerModel)
        setupAppodealBanner()
    }
    
    func presentNoLifesAlert() {
        guard let presentingViewController = self.view.viewController else { return }
        let alert = UIAlertController(title: "No lifes left", message: "Come back later", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: nil))
        presentingViewController.present(alert, animated: true, completion: nil)
    }
    
    func presentCoursePassedAlert() {
        guard let presentingViewController = self.view.viewController else { return }
        let alert = UIAlertController(title: "Course passed!", message: "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: nil))
        presentingViewController.present(alert, animated: true, completion: nil)
    }
    
    func refreshProgress() {
    //    NotificationCenter.default.post(Notification(name: .init("updateProgress")))
        guard let courseViews = self.view.containerView.subviews as? [CourseView] else { return }
        for (index,courseView) in courseViews.enumerated() {
            let courseName = model.courses[index].courseData.attributes.title
            guard let courseProgress = UserProgressInfo.shared.coursesProgress[courseName] else { continue }
            courseView.configure(with: courseProgress)
        }
    }
    
    private func generateFakeCourse() {
        guard let presentingViewController = self.view.viewController else { return }
        CurrentCourse.shared.configureWith(exercises: FakeModelGenerator.shared.getFakeExercises())
        ExercisesRouter.shared.showNextExerciseIn(viewController: presentingViewController)
    }
    
    private func setupAppodealBanner() {
        if let banner = Appodeal.banner() {
            banner.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 50)
            view.advertisementView.addSubview(banner)
            banner.translatesAutoresizingMaskIntoConstraints = false
            banner.centerXAnchor.constraint(equalTo: view.advertisementView.centerXAnchor).isActive = true
            banner.centerYAnchor.constraint(equalTo: view.advertisementView.centerYAnchor).isActive = true
            banner.widthAnchor.constraint(equalToConstant: 320).isActive = true
            banner.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
    }
    
}
