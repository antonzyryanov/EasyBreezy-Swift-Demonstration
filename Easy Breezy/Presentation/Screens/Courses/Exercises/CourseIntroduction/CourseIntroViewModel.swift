//
//  CourseIntroViewModel.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 04.12.2022.
//

import Foundation

class CourseIntroViewModel {
    
    var view: CourseIntroView!
    var model: CourseIntroModel!
    
    init(view: CourseIntroView, model: CourseIntroModel) {
        self.view = view
        self.model = model
        configure()
    }
    
    private func configure() {
        setupItems()
        guard let presentingViewController = self.view.viewController else { return }
        self.view.primaryButton.tapAction = {
            ExercisesRouter.shared.showNextExerciseIn(viewController: presentingViewController)
        }
        self.view.courseNameLabel.text = model.name
        self.view.descriptionLabel.text = model.description
        self.view.exerciseTopView.courseProgressBar.isHidden = true
        self.view.exerciseTopView.themeName.isHidden = true
    }
    
    private func setupItems() {
        var items: [ContainerViewSupporting] = []
        for item in model.items {
            let view = CheckmarkView(frame: .zero)
            view.configure(with: item)
            items.append(view)
        }
        let containerModel = ContainerModel(views: items, settings: ContainerModel.Settings(leadingOffset: 0, trailingOffset: 0, topOffset: 0, bottomOffset: 0, componentsOffset: 16), priorities: ContainerModel.Priorities(componentHeight: 100))
        self.view.containerView.configure(with: containerModel)
    }
    
}
