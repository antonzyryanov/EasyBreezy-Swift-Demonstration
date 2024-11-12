//
//  RateStarsView.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 19.09.2023.
//

import Foundation
import UIKit
import Foundation

class RateStarsView: UIView, XibLoadable {
    
    var numberOfStars: Int = 5
    
    @IBOutlet var stars: Array<UIImageView>?
    
    var starsHeightAndWeight: CGFloat = 48 {
        didSet {
            guard let stars = stars else { return }
            for star in stars {
                star.frame.size.height = starsHeightAndWeight
                star.frame.size.width = starsHeightAndWeight
            }
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
    
    private func unhighlightAll() {
        guard let stars = stars else { return }
        for star in stars {
            star.image = UIImage(named: "rate_star")
        }
    }
    
    @IBAction func oneStarTapped(_ sender: Any) {
        highlightStarsIn(quantity: 1)
    }
    
    
    @IBAction func twoStarsTapped(_ sender: Any) {
        highlightStarsIn(quantity: 2)
    }
    
    @IBAction func threeStarsTapped(_ sender: Any) {
        highlightStarsIn(quantity: 3)
    }
    
    
    @IBAction func fourStarsTapped(_ sender: Any) {
        highlightStarsIn(quantity: 4)
    }
    
    
    @IBAction func fiveStarsTapped(_ sender: Any) {
        highlightStarsIn(quantity: 5)
    }
    
    private func highlightStarsIn(quantity: Int) {
        numberOfStars = quantity
        unhighlightAll()
        guard let stars = stars else { return }
        for (index,star) in stars.enumerated() {
            if index < quantity {
                star.image = UIImage(named: "rate_star_filled")
            }
        }
    }
    
}
