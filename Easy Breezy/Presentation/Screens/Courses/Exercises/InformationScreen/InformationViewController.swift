//
//  InformationViewController.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 06.12.2022.
//

import UIKit

class InformationViewController: UIViewController {
    
    @IBOutlet var mainView: InformationView!
    var model: InformationModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let informationViewModel = InformationViewModel(model: model, view: mainView)
    }

}
