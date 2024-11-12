//
//  OnBoardingQuestionsViewModel.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 02.08.2023.
//

import Foundation
import UIKit

class OnBoardingQuestionsViewModel {
    
    var viewController: OnBoardingQuestionsViewController!
    var model: OnBoardingQuestionsModel!
    var progressItemViews: [OnboardingProgressItemView] = []
    var answerViews: [OnboardingAnswerItemView] = []
    var multipleAnswerViews: [OnboardingMultipleAnswersItemView] = []
    var currentPageIndex: Int = 0
    
    private var onboardingAnswerType: String = ""
    private var onboardingAnswer: String = ""
    
    init(viewController: OnBoardingQuestionsViewController, model: OnBoardingQuestionsModel) {
        self.viewController = viewController
        self.model = model
        NotificationCenter.default.addObserver(self, selector: #selector(updateChosenAnswer), name: .init("onboarding_answer_chosen"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateOnboardingType), name: .init("onboarding_answer_type"), object: nil)
    }
    
    func configure() {
        setupProgressBar()
        updateUI()
    }
    
    func setupProgressBar() {
        var views: [HorisontalContainerViewSupporting] = []
        for i in 0..<model.questions.count {
            var view = OnboardingProgressItemView()
            progressItemViews.append(view)
            view.widthInContainer = (self.viewController.view.frame.width - 40 )/CGFloat(model.questions.count)
            views.append(view)
        }
        self.viewController.progressBarHorizontalContainerView.configure(with:
                                                                            HorisontalContainerModel(views: views, settings: .init(topOffset: 0, bottomOffset: 0, leftOffset: 4, rightOffset: 4, componentsOffset: 0), priorities: .init(componentWidth: 1000))
        )
    }
    
    func updateUI() {
        if let deviceID = UIDevice.current.identifierForVendor?.uuidString {
            let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
            let version = appVersion ?? "0.0"
            if currentPageIndex != model.questions.count {
                EventTracker.shared.log(event: "onboarding", with: [:], and: ["step": String(currentPageIndex),"username": deviceID,"version": version, "type": "single","answer": self.onboardingAnswer,"question" : self.viewController.questionLabel.text ?? ""])
                //"step": String(currentPageIndex)
            }
        }
        if currentPageIndex == model.questions.count {
            var answers: [String] = []
            for view in multipleAnswerViews {
                if view.isChosen {
                    answers.append(view.answerLabel.text ?? "")
                    sendMultipleAnswersAnalytics(view: view)
                }
            }
            DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "LoadingProcessViewController", bundle: nil)
                guard let loadingProcessViewController = storyboard.instantiateViewController(withIdentifier: "LoadingProcessViewController") as? LoadingProcessViewController else { return }
            loadingProcessViewController.modalPresentationStyle = .overCurrentContext
                self.viewController.present(loadingProcessViewController, animated: true)
        }
            return
        }
        updateProgressBar()
        self.viewController.emojiImage.image = UIImage(named: model.questions[currentPageIndex].bigEmoji)
        self.viewController.questionLabel.text = model.questions[currentPageIndex].question
        setupAnswersContainerView()
        self.viewController.nextPageButton.isUserInteractionEnabled = false
        currentPageIndex += 1
    }
    
    private func setupAnswersContainerView() {
        for subView in self.viewController.answersContainerView.subviews {
            subView.removeFromSuperview()
        }
        
        
        if currentPageIndex == model.questions.count - 1 {
            viewController.answersContainerViewHeight.priority = UILayoutPriority(1000)
            viewController.multipleAnswersContainerViewHeight.priority = UILayoutPriority(1)
            var views: [ContainerViewSupporting] = []
            for (i,answerModel) in model.questions[currentPageIndex].answers.enumerated() {
                var view = OnboardingMultipleAnswersItemView()
                view.itemChosenAction = {
                    self.viewController.nextPageButton.isUserInteractionEnabled = true
                    for view in self.answerViews {
                        view.isChosen = false
                    }
                }
                view.answerLabel.text = answerModel.answer
                multipleAnswerViews.append(view)
                views.append(view)
            }
            
            self.viewController.multipleAnswersContainerView.configure(with:
                                                                ContainerModel(views: views, settings: ContainerModel.Settings(leadingOffset: 0, trailingOffset: 0, topOffset: 0, bottomOffset: 0, componentsOffset: 16), priorities: ContainerModel.Priorities.init(componentHeight: 100))
            )
            
            return
        }
        
        
        answerViews = []
        var views: [ContainerViewSupporting] = []
        for (i,answerModel) in model.questions[currentPageIndex].answers.enumerated() {
            var view = OnboardingAnswerItemView()
            view.itemChosenAction = {
                self.viewController.nextPageButton.isUserInteractionEnabled = true
                for view in self.answerViews {
                    view.isChosen = false
                }
            }
            view.emojiImage.image = UIImage(named: answerModel.emojiImage)
            view.answerLabel.text = answerModel.answer
            answerViews.append(view)
            views.append(view)
        }
        
        
//        for (i,answerModel) in model.answers[currentPageIndex].answers.enumerated() {
//            var view = OnboardingAnswerItemView()
//            view.itemChosenAction = {
//                for view in self.answerViews {
//                    view.isChosen = false
//                    view.emojiImage.image = UIImage(named: self.model.answers[self.currentPageIndex].emojiImage)
//                    view.answerLabel.text = answerModel
//                }
//            }
//            answerViews.append(view)
//            views.append(view)
//        }
        
        self.viewController.answersContainerView.configure(with:
                                                            ContainerModel(views: views, settings: ContainerModel.Settings(leadingOffset: 0, trailingOffset: 0, topOffset: 0, bottomOffset: 0, componentsOffset: 16), priorities: ContainerModel.Priorities.init(componentHeight: 100))
        )
    }
    
    private func sendMultipleAnswersAnalytics(view: OnboardingMultipleAnswersItemView) {
        if let deviceID = UIDevice.current.identifierForVendor?.uuidString {
            let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
            let version = appVersion ?? "0.0"
            EventTracker.shared.log(event: "onboarding", with: [:], and: ["step": String(currentPageIndex), "username": deviceID,"version": version,"type": "multiple","answer":view.answerLabel.text ?? "","question" : self.viewController.questionLabel.text ?? ""])
            //"step": String(currentPageIndex)
        }
    }
    
    private func updateProgressBar() {
        progressItemViews[currentPageIndex].isPageShown = true
    }
    
//    @objc func updateChosenAnswer() {
//        
//    }
    
    @objc func updateChosenAnswer(_ notification: NSNotification) {
        if let answer = notification.userInfo?["answer"] as? String {
            self.onboardingAnswer = answer
        }
    }
    
//    @objc func updateOnboardingType() {
//        
//    }
    
    @objc func updateOnboardingType(_ notification: NSNotification) {
        if let answerType = notification.userInfo?["answerType"] as? String {
            self.onboardingAnswerType = answerType
        }
    }
    
}
