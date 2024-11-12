//
//  RightOrderExerciseView.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 10.12.2022.
//

import UIKit

class RightOrderExerciseView: UIView, MainView {
    
    
    @IBOutlet weak var exerciseTopView: ExerciseTopView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var commentaryLabel: UILabel!
    @IBOutlet weak var contentItemsContainerView: ContainerView!
    
    @IBOutlet weak var scrollView: PassTouchesScrollView!
    @IBOutlet weak var horizontalScrollView: PassTouchesScrollView!
    @IBOutlet weak var stepsContainerView: HorisontalContainerView!
    @IBOutlet weak var funnelContainerView: ContainerView!
    @IBOutlet weak var primaryButton: PrimaryButton!
    @IBOutlet weak var continueButtonHolder: NSLayoutConstraint!
    @IBOutlet weak var commentaryView: CommentaryView!
    @IBOutlet weak var commentaryViewBottom: NSLayoutConstraint!
    @IBOutlet weak var commentaryViewHeight: NSLayoutConstraint!
    
}
