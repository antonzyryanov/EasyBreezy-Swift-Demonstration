//
//  PurchasesProcessings.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 30.04.2023.
//

import ApphudSDK
import Foundation
import StoreKit

class PurchasesProcessings {
    static var paywall: ApphudPaywall?
    static var products: [ApphudProduct]?
    
    static let currencyConverter = CurrencyConverter()
    
    static func loadProducts() async {
        let paywall = await Apphud.paywall("easy_breezy_test")
        guard let products = paywall?.products else { return }
        self.products = products
//        currencyConverter.updateExchangeRates(completion: {
//            print("TEST GOYDA 2")
//            
//            var currentValuePrice = PurchasesProcessings.products![0].skProduct?.price ?? 0
//            var priceLocale = PurchasesProcessings.products![0].skProduct?.priceLocale ?? .init(identifier: "USD")
//            print("TEST GOYDA 5 \(priceLocale.identifier)")
//            let currencyString = priceLocale.identifier.components(separatedBy: "=")[1]
//            print("TEST GOYDA 7 \(currencyString)")
//            var inputCurrency: Currency = Currency.init(rawValue: currencyString) ?? .USD
//            let formattedResult = self.currencyConverter.convertAndFormat(10, valueCurrency: inputCurrency, outputCurrency: .USD, numberStyle: .decimal, decimalPlaces: 4)
//            print("TEST Formatted Result (\(currentValuePrice) \(currencyString) to USD): \(formattedResult!) •••")
//        })
    }
    
    static func purchase() {
//        let paywall = await Apphud.paywall("easy_breezy_test")
//        guard let products = paywall?.products else { return }
//        self.products = products
        Apphud.purchase(PurchasesProcessings.products![0]) { result in
                        if let subscription = result.subscription, subscription.isActive() {
                            // has active subscription
                            print("TEST GOYDA 1")
                            currencyConverter.updateExchangeRates(completion: {
                                
                                print("TEST GOYDA 2")
                                
                                var currentValuePrice = PurchasesProcessings.products![0].skProduct?.price ?? 0
                                var priceLocale = PurchasesProcessings.products![0].skProduct?.priceLocale ?? .init(identifier: "USD")
                                print("TEST GOYDA 5 \(priceLocale.identifier)")
                                let currencyString = priceLocale.identifier.components(separatedBy: "=")[1]
                                print("TEST GOYDA 7 \(currencyString)")
                                var inputCurrency: Currency = Currency.init(rawValue: currencyString) ?? .USD
                                let priceUSD = self.currencyConverter.convertAndFormat(10, valueCurrency: inputCurrency, outputCurrency: .USD, numberStyle: .decimal, decimalPlaces: 4) ?? "no value"
                                print("TEST Formatted Result (\(currentValuePrice) \(currencyString) to USD): \(priceUSD) •••")
                                
                                EventTracker.shared.log(event: "subscription", with: [:], and: ["username":UserProfile.shared.userInfo.user.username,
                                                                                                "period": "\(PurchasesProcessings.products![0].skProduct?.subscriptionPeriod?.numberOfUnits ?? 777)",
                                                                                                "price": "\(PurchasesProcessings.products![0].skProduct?.localizedPrice ?? "")",
                                                                                                "price_usd": "\(priceUSD)",
                                                                                                "subscription_id":
                                                                                                    "\(PurchasesProcessings.products![0].skProduct?.productIdentifier ?? "")",
                                                                                                "is_trial": "\(subscription.isIntroductoryActivated)",
                                                                                                "trial_period": "\(PurchasesProcessings.products![0].skProduct?.discounts.first?.numberOfPeriods ?? 777)",
                                                                                                "rebill":"\(subscription.isInRetryBilling)"
                                                                                               ])
                                if let canceledAtDate = subscription.canceledAt {
                                    UserDefaults.standard.set(canceledAtDate, forKey: "subscription_cancel_date")
                                    UserDefaults.standard.setValue(PurchasesProcessings.products![0].skProduct?.productIdentifier, forKey: "subscription_cancel_id")
                                }
                                
                            })
                            
                        } else if let purchase = result.nonRenewingPurchase, purchase.isActive() {
                            // has active non-renewing purchase
                        } else {
                            // handle error or check transaction status.
                        }
                    }
    }
    
    
    
}
