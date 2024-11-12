//
//  AdvertisementManager.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 15.05.2023.
//

import Foundation
import UIKit
import Appodeal

class AdvertisementManager {
    
    static let shared = AdvertisementManager()
    
    var advertisementNeedsToBeShown: Bool = false
    
    var isShown = false
    
    func checkIfAdvertisementNeedsToBeShown() {
        if advertisementNeedsToBeShown {
            showInterstitial()
        }
    }
    
    func showInterstitial() {
        if isShown { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if Appodeal.isReadyForShow(with: .interstitial) {
                let topViewController = UIApplication.topViewController()
                Appodeal.showAd(AppodealShowStyle.interstitial, rootViewController: topViewController)
               // Appodeal.setInterstitialDelegate(self)
                self.isShown = true
            }
            self.advertisementNeedsToBeShown = false
        }
    }
    
    func hideAppodealBanner() {
        
    }
    
}
