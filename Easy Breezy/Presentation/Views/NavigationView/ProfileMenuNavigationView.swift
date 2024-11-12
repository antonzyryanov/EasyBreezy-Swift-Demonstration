//
//  NavigationView.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 23.08.2023.
//

import Foundation
import UIKit

class ProfileMenuNavigationView: UIView, XibLoadable {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    var presentingViewController: UIViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromXib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupFromXib()
    }
    
    func configureWith(title: String) {
        self.title.text = title
    }
    
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        presentingViewController?.dismiss(animated: true)
    }
    
}
