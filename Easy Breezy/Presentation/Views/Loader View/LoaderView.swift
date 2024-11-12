//
//  LoaderView.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 24.02.2023.
//

import UIKit

class LoaderView: UIView, XibLoadable {
    
    @IBOutlet weak var loaderImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromXib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupFromXib()
    }
    
    func customizeView() {
        let image = UIImage.gifImageWithName("loader_2")
        self.loaderImageView.image = image
    }

}
