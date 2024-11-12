//
//  FunnelExerciseView.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 10.12.2022.
//

import UIKit

class TermsComparisonExerciseView: UIView, MainView {

    @IBOutlet weak var exerciseTopView: ExerciseTopView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var commentaryLabel: UILabel!
    @IBOutlet weak var contentItemsContainerView: ContainerView!
    
    @IBOutlet weak var scrollView: PassTouchesScrollView!
    @IBOutlet weak var horizontalScrollView: PassTouchesScrollView!
    @IBOutlet weak var termsContainerView: HorisontalContainerView!
    @IBOutlet weak var funnelContainerView: ContainerView!
    @IBOutlet weak var primaryButton: PrimaryButton!
    @IBOutlet weak var commentaryView: CommentaryView!
    @IBOutlet weak var commentaryViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var continueButtonZeroHeightPriority: NSLayoutConstraint!
    @IBOutlet weak var commentaryViewBottom: NSLayoutConstraint!
}
