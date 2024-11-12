//
//  LifesViewModel.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 10.12.2022.
//

import Foundation
import UIKit

class LifesViewModel {
    
    var view: LifesView!
    var numberOfLifes: Int = 3
    
    init(view: LifesView) {
        self.view = view
    }
    
    func decreaseNumberOfLifes() {
        self.numberOfLifes -= 1
        set(numberOfLifes: self.numberOfLifes)
    }
    
    func set(numberOfLifes: Int) {
        self.numberOfLifes = numberOfLifes
        switch numberOfLifes {
        case 2:
            self.view.firstLife.image = UIImage(named: "unactive_life")
        case 1:
            self.view.firstLife.image = UIImage(named: "unactive_life")
            self.view.secondLife.image = UIImage(named: "unactive_life")
        case 0:
            self.view.firstLife.image = UIImage(named: "unactive_life")
            self.view.secondLife.image = UIImage(named: "unactive_life")
            self.view.thirdLife.image = UIImage(named: "unactive_life")
        default:
            _ = ""
        }
    }
    
}
