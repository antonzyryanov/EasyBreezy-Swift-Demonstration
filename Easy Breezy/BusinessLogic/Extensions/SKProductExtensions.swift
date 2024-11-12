//
//  SKProductExtensions.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 29.11.2023.
//

import Foundation
import StoreKit

extension SKProduct {
    
    fileprivate static var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
    
    var localizedPrice: String {
        if self.price == 0.00 {
            return NSLocalizedString("Free", comment: "")
        } else {
            let formatter = SKProduct.formatter
            formatter.locale = self.priceLocale
            
            guard let formattedPrice = formatter.string(from: self.price)else {
                return NSLocalizedString("Unknown Price", comment: "")
            }
            
            return formattedPrice
        }
    }
    
    func localizedPeriodPrice(period: Int) -> String {
        if self.price == 0.00 {
            return NSLocalizedString("Free", comment: "")
        } else {
            let formatter = SKProduct.formatter
            formatter.locale = self.priceLocale
            
            let periodPrice = self.price.dividing(by: NSDecimalNumber(value: period))
            
            guard let formattedPrice = formatter.string(from: periodPrice)else {
                return NSLocalizedString("Unknown Price", comment: "")
            }
            
            return formattedPrice
        }
    }
    
}
