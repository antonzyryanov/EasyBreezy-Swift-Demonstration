//
//  ContainerText.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 06.12.2022.
//

import UIKit

class ContainerText: UIView, XibLoadable, ContainerViewSupporting {
    
    var heightInContainer: CGFloat = 777
    
    @IBOutlet weak var textView: CustomTextView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromXib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupFromXib()
    }
    
    init(text: String) {
        super.init(frame: .zero)
        setupFromXib()
        let customTextViewModel = CustomTextViewModel(view: self.textView, model: CustomTextModel(from: text))
    }

}
