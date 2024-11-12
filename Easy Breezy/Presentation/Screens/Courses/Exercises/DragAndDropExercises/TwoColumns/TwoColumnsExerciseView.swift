//
//  TwoColumnsExerciseView.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 10.12.2022.
//

import UIKit

class TwoColumnsExerciseView: UIView, MainView {
    
    @IBOutlet weak var exerciseTopView: ExerciseTopView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var commentaryLabel: UILabel!
    
    @IBOutlet weak var contentItemsContainerView: ContainerView!
    
    @IBOutlet weak var horizontalScrollView: PassTouchesScrollView!
    @IBOutlet weak var scrollView: PassTouchesScrollView!
    @IBOutlet weak var answersContainerView: HorisontalContainerView!
    @IBOutlet weak var firstChosenColumnContainerView: ContainerView!
    @IBOutlet weak var secondChosenColumnContainerView: ContainerView!
    @IBOutlet weak var primaryButton: PrimaryButton!
    @IBOutlet weak var continueButtonHolder: NSLayoutConstraint!
    @IBOutlet weak var commentaryView: CommentaryView!
    @IBOutlet weak var commentaryViewHeight: NSLayoutConstraint!
    @IBOutlet weak var commentaryViewBottom: NSLayoutConstraint!
    @IBOutlet weak var firstColumnLabel: UILabel!
    @IBOutlet weak var secondColumnLabel: UILabel!
    
}
