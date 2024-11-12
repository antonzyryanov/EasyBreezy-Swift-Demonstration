//
//  LoginViewModel.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 29.12.2022.
//

import Foundation
import UIKit
import AffiseAttributionLib

class LoginViewModel {
    
    var model: LoginModel!
    var view: LoginView!
    
    var curentIndex: Int = 0
    
    init(model: LoginModel, view: LoginView) {
        self.model = model
        self.view = view
        configure()
    }
    
    private func configure() {
        self.view.configure(with: self.model)
        self.view.primaryButton.tapAction = {
            if self.curentIndex == self.model.onBoardings.count - 1 {
                guard let viewController = self.view.viewController as? LoginViewController else { return }
                viewController.dismiss(animated: true)
                let defaults = UserDefaults.standard
                defaults.set(true, forKey: "isOnBoardingPassed")
                viewController.openAuthorizationScreen()
                return
            }
            self.curentIndex += 1
            self.trackThatOnBoardingStepWasShown(index: self.curentIndex)
            self.view.onBoardingSheet.pageControl.currentPage = self.curentIndex
            self.view.configure(with: self.model, and: self.curentIndex)
        }
    }
    
    func trackThatOnBoardingStepWasShown(index: Int) {
        if let deviceID = UIDevice.current.identifierForVendor?.uuidString {
            let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
            let version = appVersion ?? "0.0"
         //   EventTracker.shared.log(event: "onboarding", with: ["step": String(index+1)], and: ["username": deviceID,"version": version])
            Affise.shared.sendEvent(event: CustomId05Event(custom: "onboarding", timeStampMillis: Int64(Date().timeIntervalSince1970 * 1000), userData: UserProfile.shared.userInfo.user.username).apply {
                                $0.addPredefinedParameter(parameter: .PARAM_01, value: String(index+1))
                                $0.addPredefinedParameter(parameter: .PARAM_02, value: deviceID)
                            })
            print("OnBoarding \(index+1) was shown event tracked")
        }
    }
    
}
