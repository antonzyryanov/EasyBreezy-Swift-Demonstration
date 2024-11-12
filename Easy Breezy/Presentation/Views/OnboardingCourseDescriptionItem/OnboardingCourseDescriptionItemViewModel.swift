//
//  OnboardingCourseDescriptionItemViewModel.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 25.08.2023.
//

import Foundation
import UIKit

class OnboardingCourseDescriptionItemViewModel {
    
    var view: OnboardingCourseDescriptionItem!
    var model: OnboardingCourseDescriptionItemModel!
    
    init(view: OnboardingCourseDescriptionItem, model: OnboardingCourseDescriptionItemModel) {
        self.view = view
        self.model = model
        configure()
    }
    
    private func configure() {
        setupContainerView()
        self.view.courseImage.image = UIImage.gifImageWithName(model.imageName)
        self.view.courseName.text = model.courseName
    }
    
    private func setupContainerView() {
        var views: [ContainerViewSupporting] = []
        for theme in model.themes {
            let view = OnboardingCourseThemeItem()
            view.configureWith(model: theme)
            views.append(view)
        }
        let containerModel = ContainerModel(views: views, priorities: .init(componentHeight: 100))
        view.themesContainerView.configure(with: containerModel)
    }
    
}
