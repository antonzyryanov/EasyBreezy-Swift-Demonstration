//
//  InformationViewModel.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 06.12.2022.
//

import Foundation

class InformationViewModel {
    
    var view: InformationView!
    var model: InformationModel!
    var exerciseTopViewModel: ExerciseTopViewModel!
    
    init(model: InformationModel, view: InformationView) {
        self.model = model
        self.view = view
        configure()
    }
    
    private func configure() {
        var views: [ContainerViewSupporting] = []
        for informationItem in model.informationItems {
            views.append(createInformationItemView(from: informationItem))
        }
        let containerModel = ContainerModel(views: views, settings: ContainerModel.Settings(leadingOffset: 0, trailingOffset: 0, topOffset: 0, bottomOffset: 0, componentsOffset: 16), priorities: ContainerModel.Priorities.init(componentHeight: 100))
        view.containerView.configure(with: containerModel)
        self.exerciseTopViewModel = ExerciseTopViewModel(view: view.exerciseTopView)
        exerciseTopViewModel.configure(with: CurrentCourse.shared.completionPercent)
        self.view.themeLabel.text = model.theme
        self.view.exerciseTopView.themeName.text = self.model.themeName
        guard let presentingViewController = self.view.viewController else { return }
        self.view.continueButton.tapAction = {
            ExercisesRouter.shared.showNextExerciseIn(viewController: presentingViewController)
        }
        self.view.scrollView.showsVerticalScrollIndicator = false
        self.exerciseTopViewModel.lifesViewModel.set(numberOfLifes: UserProfile.shared.numberOfLifes)
        AdvertisementManager.shared.checkIfAdvertisementNeedsToBeShown()
    }
    
    private func createInformationItemView(from informationItem: ContainerItem) -> ContainerViewSupporting {
        switch informationItem.contentType {
        case .text:
            return ContainerText(text: informationItem.content)
        case .image:
            return ContainerImage(image: informationItem.content)
        }
    }
    
}
