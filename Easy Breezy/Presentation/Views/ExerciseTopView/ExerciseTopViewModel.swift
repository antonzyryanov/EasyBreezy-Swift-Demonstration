//
//  ExerciseTopViewModel.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 10.01.2023.
//

import Foundation
import Appodeal

class ExerciseTopViewModel {
    
    private var appodealBanner: UIView?
    var view: ExerciseTopView!
    var lifesViewModel: LifesViewModel!
    
    init(view: ExerciseTopView) {
        self.view = view
        self.lifesViewModel = LifesViewModel(view: view.lifesView)
        setupAdBannerIfNeeded()
    }
    
    func configure(with percentage: Double) {
        self.view.courseProgressBar.configure(with: percentage)
    }
    
    func decreaseNumberOfLifes() {
        self.lifesViewModel.decreaseNumberOfLifes()
    }
    
    private func setupAdBannerIfNeeded() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//            if let banner = Appodeal.banner() {
//                banner.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 50)
//                self.view.addSubview(banner)
//                banner.translatesAutoresizingMaskIntoConstraints = false
//                banner.centerXAnchor.constraint(equalTo: self.view.advertisementView.centerXAnchor).isActive = true
//                banner.centerYAnchor.constraint(equalTo: self.view.advertisementView.centerYAnchor).isActive = true
//                banner.widthAnchor.constraint(equalToConstant: 320).isActive = true
//                banner.heightAnchor.constraint(equalToConstant: 50).isActive = true
//                self.appodealBanner = banner
//            }
//        }
    }
    
}
