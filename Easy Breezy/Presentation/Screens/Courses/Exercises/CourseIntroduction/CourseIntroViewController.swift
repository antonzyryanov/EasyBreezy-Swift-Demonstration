//
//  CourseIntroViewController.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 04.12.2022.
//

import UIKit

class CourseIntroViewController: UIViewController {

    @IBOutlet var mainView: CourseIntroView!
    var model: CourseIntroModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationView()
        guard let model = self.model else { return }
        let courseIntroViewModel = CourseIntroViewModel(view: self.mainView, model: model )
        self.mainView.scrollView.showsVerticalScrollIndicator = false
    }
    

    private func setupNavigationView() {
        self.mainView.layoutIfNeeded()
    }

}
