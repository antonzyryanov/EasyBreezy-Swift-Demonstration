//
//  AnswerScrollViewSizeChanger.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 14.03.2023.
//

import Foundation
import UIKit

class AnswerScrollViewSizeChanger {
    
    static let shared = AnswerScrollViewSizeChanger()
    
    func calculateScrollViewSize(containerView: HorisontalContainerView) -> CGFloat? {
        guard let lastVisibleView = containerView.subviews.last(where: { $0.isHidden == false }) else { return nil }
        return lastVisibleView.frame.maxX + 16
    }
    
}
