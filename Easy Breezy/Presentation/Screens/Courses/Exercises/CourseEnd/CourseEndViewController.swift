//
//  CourseEndViewController.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 23.01.2023.
//

import UIKit

class CourseEndViewController: UIViewController {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var continueButton: PrimaryButton!
    
    var model: CourseEndModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    

    func configure() {
        self.messageLabel.text = model.message
        self.imageView.image = UIImage(named: model.image)
        self.continueButton.tapAction = {
            ExercisesRouter.shared.showNextExerciseIn(viewController: self)
        }
    }

}
