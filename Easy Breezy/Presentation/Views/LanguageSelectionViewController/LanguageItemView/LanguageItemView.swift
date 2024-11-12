//
//  LanguageItemView.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 23.08.2023.
//

import Foundation
import UIKit

class LanguageItemView: UIView, XibLoadable, ContainerViewSupporting {
    
    var heightInContainer: CGFloat = 60
    
    let nc = NotificationCenter.default
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var bottomBorder: UIView!
    @IBOutlet weak var checkmark: UIImageView!
    
    var isSelected: Bool = false {
        didSet {
            nc.post(name: Notification.Name("user_selected_language"), object: nil)
            if isSelected {
                languageWasSelected()
            } else {
                checkmark.isHidden = true
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        nc.addObserver(self, selector: #selector(uncheck), name: Notification.Name("user_selected_language"), object: nil)
        setupFromXib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupFromXib()
    }
    
    func customizeView() {
        self.checkmark.isHidden = true
    }
    
    func configureWith(language: String) {
        self.title.text = language
    }
    
    private func languageWasSelected() {
        self.checkmark.isHidden = false
    }
    
    @objc private func uncheck() {
        checkmark.isHidden = true
    }
    
    @IBAction func itemSelected(_ sender: Any) {
        isSelected = true
    }
    
}
