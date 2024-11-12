//
//  MultipleOptionChoiseView.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 08.12.2022.
//

import UIKit

class MultipleOptionChoiseView: UIView {
    @IBOutlet weak var exerciseTopView: ExerciseTopView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerView: ContainerView!
    @IBOutlet weak var commentaryView: CommentaryView!
    @IBOutlet weak var commentaryViewHeight: NSLayoutConstraint!
    @IBOutlet weak var continueButton: PrimaryButton!
    @IBOutlet weak var continueButtonZeroHeightPriority: NSLayoutConstraint!
    @IBOutlet weak var questionTextView: CustomTextView!
    @IBOutlet weak var commentaryViewBottom: NSLayoutConstraint!
}
