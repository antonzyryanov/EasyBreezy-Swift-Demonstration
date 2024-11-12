//
//  TrialOfferViewController.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 30.07.2023.
//

import UIKit
import ApphudSDK

class TrialOfferViewController: UIViewController {
    
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var restorePurchasesButton: UIButton!
    @IBOutlet weak var termsOfUseAndPrivacyPolicyButton: UIButton!
    
    @IBOutlet weak var monthPrice: UILabel!
    
    var previousScreen: String = "source_not_defined"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupPrice()
        EventTracker.shared.log(event: "subscription_screen", with: [:], and: ["source":previousScreen])
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func mainButtonTapped(_ sender: Any) {
        purchase()
        EventTracker.shared.log(event: "subscribe_button_clicked", with: [:], and: ["username":UserProfile.shared.userInfo.user.username])
    }
    
    private func purchase() {
//        Task {
//            await PurchasesProcessings.purchase()
//        }
        PurchasesProcessings.purchase()
    }
    
    private func setupPrice() {
        if let products = PurchasesProcessings.products, let product = products.first?.skProduct {
            self.monthPrice.text = product.localizedPeriodPrice(period: product.subscriptionPeriod?.numberOfUnits ?? 12)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
