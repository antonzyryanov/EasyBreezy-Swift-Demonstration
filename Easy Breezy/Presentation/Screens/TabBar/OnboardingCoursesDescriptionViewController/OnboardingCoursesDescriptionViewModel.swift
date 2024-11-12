//
//  OnboardingCoursesDescriptionViewModel.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 25.08.2023.
//

import Foundation
import UIKit

class OnboardingCoursesDescriptionViewModel {
    
    var viewController: OnboardingCoursesDescriptionViewController!
    var model: OnboardingCoursesDescriptionModel!
    
    init(viewController: OnboardingCoursesDescriptionViewController, model: OnboardingCoursesDescriptionModel) {
        self.viewController = viewController
        self.model = model
        configure()
    }
    
    private func configure() {
        setupContainerView()
        self.viewController.continueButton.tapAction = {
            self.viewController.dismiss(animated: true)
        }
        self.viewController.continueButton.title = "Continue"
    }
    
    private func setupContainerView() {
        var views: [ContainerViewSupporting] = []
        for course in model.courses {
            let view = OnboardingCourseDescriptionItem()
            let onboardingCourseDescriptionItemViewModel = OnboardingCourseDescriptionItemViewModel(view: view, model: course)
            views.append(view)
        }
        let containerModel = ContainerModel(views: views, settings: .init(componentsOffset: 16), priorities: .init(componentHeight: 100))
        viewController.coursesContainerView.configure(with: containerModel)
    }
    
}
