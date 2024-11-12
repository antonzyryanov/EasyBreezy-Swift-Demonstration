//
//  ContainerImage.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 06.12.2022.
//

import UIKit
import SDWebImage 

class ContainerImage: UIView, XibLoadable, ContainerViewSupporting {
    
    var heightInContainer: CGFloat = 777
    
    @IBOutlet weak var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromXib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupFromXib()
    }
    
    init(image: String) {
        super.init(frame: .zero)
        setupFromXib()
        let url = URL(string: image)
        self.imageView.sd_setImage(with: url, completed: nil)
    }

}
