//
//  SubscriptionView.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 23.01.2023.
//

import UIKit
import ApphudSDK

class SubscriptionView: UIView, XibLoadable {
    
    @IBOutlet weak var monthlySubscriptionButton: UIButton!
    @IBOutlet weak var yearlySubscriptionButton: UIButton!
    @IBOutlet weak var lifetimeSubscriptionButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromXib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupFromXib()
    }
    
    func customizeView() {
        monthlySubscriptionButton.setTitle("", for: .normal)
        yearlySubscriptionButton.setTitle("", for: .normal)
        lifetimeSubscriptionButton.setTitle("", for: .normal)
    }
    
    
    @IBAction func monthSubscriptionChosen(_ sender: UIButton) {
        guard let product = PurchasesProcessings.products?[0] else {return }
        Apphud.purchase(product) { result in
                        if let subscription = result.subscription, subscription.isActive() {
                            // has active subscription
                        } else if let purchase = result.nonRenewingPurchase, purchase.isActive() {
                            // has active non-renewing purchase
                        } else {
                            // handle error or check transaction status.
                        }
                    }
    }
    
}
