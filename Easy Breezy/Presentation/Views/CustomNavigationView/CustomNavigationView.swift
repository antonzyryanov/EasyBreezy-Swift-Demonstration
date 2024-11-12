//
//  CustomNavigationView.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 10.12.2022.
//

import UIKit

class CustomNavigationView: UIView, XibLoadable {

    @IBOutlet weak var goBackButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromXib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupFromXib()
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        guard let viewController = self.viewController else { return }
        viewController.dismiss(animated: true)
    }
    
}
