//
//  LanguageSelectionViewModel.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 23.08.2023.
//

import Foundation

class LanguageSelectionViewModel {
    
    var view: LanguageSelectionView!
    
    init(view: LanguageSelectionView) {
        self.view = view
        configure()
    }
    
    private func configure() {
        self.setupLanguageContainerView()
    }
    
    private func setupLanguageContainerView() {
        var containerViews: [ContainerViewSupporting] = []
        let ukEnglishLanguageItem = LanguageItemView()
        ukEnglishLanguageItem.configureWith(language: "English (UK)")
        let englishLanguageItem = LanguageItemView()
        englishLanguageItem.configureWith(language: "English")
        englishLanguageItem.isSelected = true
        let russianLanguageItem = LanguageItemView()
        russianLanguageItem.configureWith(language: "Русский")
        containerViews.append(ukEnglishLanguageItem)
        containerViews.append(englishLanguageItem)
        containerViews.append(russianLanguageItem)
        let model = ContainerModel(views:containerViews)
        view.languagesContainerView.configure(with: model)
    }
    
}
