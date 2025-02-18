//
//  DoubleExtensions.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 08.11.2023.
//

import Foundation

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
