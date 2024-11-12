//
//  CourseView.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 04.12.2022.
//

import Foundation
import UIKit

class CourseView: UIView, XibLoadable, ContainerViewSupporting {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var courseProgressBar: CourseProgressBar!
    @IBOutlet weak var backgroundView: RoundedCornersView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lock: UIImageView!
    
    var heightInContainer: CGFloat = 166
    
    var tapAction: (()->Void)?
    
    var isDisabled: Bool = false {
        didSet {
            if isDisabled {
                backgroundView.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
                lock.isHidden = false
                percentLabel.isHidden = true
            } else {
                backgroundView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
                lock.isHidden = true
                percentLabel.isHidden = false
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromXib()
        lock.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupFromXib()
        lock.isHidden = true
    }
    
    func configure(with course: Course) {
        self.nameLabel.text = course.title
        self.percentLabel.text = String(course.completionPercentage.rounded(toPlaces: 2)) + " %"
        self.courseProgressBar.configure(with: course.completionPercentage)
        self.imageView.image = UIImage(named: course.image)
    }
    
    func configure(with progressPercentage: Double) {
        self.percentLabel.text = String(progressPercentage.rounded(toPlaces: 2)) + " %"
        self.courseProgressBar.configure(with: progressPercentage)
    }
    
    @IBAction func tapAction(_ sender: Any) {
        tapAction?()
    }
    
}
