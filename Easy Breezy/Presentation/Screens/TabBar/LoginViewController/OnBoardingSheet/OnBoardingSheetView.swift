//
//  OnBoardingSheetView.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 29.12.2022.
//

import UIKit

class OnBoardingSheetView: UIView, XibLoadable {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var imageViewHolder: UIView!
    
    @IBOutlet weak var subscriptionViewHolder: NSLayoutConstraint!
    
    @IBOutlet weak var subscriptionView: SubscriptionView!
    
    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var subscriptionViewHeight: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromXib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupFromXib()
    }
    
    func customizeView() {
        pageControl.subviews.forEach {
            $0.transform = CGAffineTransform(scaleX: 2, y: 2)
        }
        subscriptionView.isHidden = true
        subscriptionView.isUserInteractionEnabled = false
    }
    
}
