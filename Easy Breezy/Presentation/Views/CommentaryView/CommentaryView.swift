//
//  CommentaryView.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 07.12.2022.
//

import UIKit

class CommentaryView: UIView, XibLoadable {
    
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var tryAgainButton: TryAgainButton!
    
    var isExercisePassed: Bool = false {
        didSet {
            if isExercisePassed {
                self.statusImage.image = UIImage(named: "right_answer")
            } else {
                self.statusImage.image = UIImage(named: "wrong_answer")
            }
            self.tryAgainButton.isExercisePassed = self.isExercisePassed
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromXib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupFromXib()
    }
    
    init(text: String, isExercisePassed: Bool = false) {
        super.init(frame: .zero)
        textLabel.text = text
        self.isExercisePassed = isExercisePassed
    }
    
    func configure(text: String, isExercisePassed: Bool = false) {
        textLabel.text = text
        self.isExercisePassed = isExercisePassed
    }

}
