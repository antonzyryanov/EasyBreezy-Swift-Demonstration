//
//  AppDelegate.swift
//  Test
//
//  Created by Anton Zyryanov on 30/11/2022.
//  Copyright © 2018 Frogames. All rights reserved.
//
import UIKit
import Amplitude
import AppsFlyerLib
import AppTrackingTransparency
import ApphudSDK
import Foundation
import Appodeal
import AffiseAttributionLib
import AffiseSKAdNetwork
import GoogleSignIn
import SideMenu
import LGSideMenuController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        
        let profileStoryboard = UIStoryboard(name: "ProfileMenuViewController", bundle: nil)
        let profileMenuViewController = profileStoryboard.instantiateViewController(withIdentifier: "ProfileMenuViewController")
        
        let sideMenuController = LGSideMenuController(rootViewController: initialViewController,
                                                             leftViewController: profileMenuViewController)
        
        self.window?.rootViewController = sideMenuController
        self.window?.makeKeyAndVisible()
        setupApphud()
        setupAmplitude()
        setupAppsFlyer()
        setupAppodeal()
        setupAffise(application: application, launchOptions: launchOptions)
        AppConfig.shared.httpsMode = false
        
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if error != nil || user == nil {
              // Show the app's signed-out state.
            } else {
              // Show the app's signed-in state.
            }
        }
        checkIfSubscriptionCanceled()
        
//        SideMenuController.preferences.basic.statusBarBehavior = .hideOnMenu
//        SideMenuController.preferences.basic.position = .below
//        SideMenuController.preferences.basic.direction = .left
//        SideMenuController.preferences.basic.enablePanGesture = true
        
//        var currentValuePrice = PurchasesProcessings.products![0].skProduct?.price ?? 0
//var priceLocale = PurchasesProcessings.products![0].skProduct?.priceLocale ?? .init(identifier: "USD")
//        print("TEST GOYDA \(priceLocale)")
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        UserProgressInfo.shared.saveProgress()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        AppsFlyerLib.shared().start()
    }
    
    func application(
      _ app: UIApplication,
      open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
      var handled: Bool

      handled = GIDSignIn.sharedInstance.handle(url)
      if handled {
        return true
      }

      // Handle other custom URL types.

      // If not handled by this app, return false.
      return false
    }
    
    private func setupApphud() {
        Apphud.start(apiKey: "")
        // Get Paywall by Identifier
        Task {
            await PurchasesProcessings.loadProducts()
        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 30.0) {
//            Apphud.purchase(PurchasesProcessings.products![0]) { result in
//                            if let subscription = result.subscription, subscription.isActive() {
//                                // has active subscription
//                            } else if let purchase = result.nonRenewingPurchase, purchase.isActive() {
//                                // has active non-renewing purchase
//                            } else {
//                                // handle error or check transaction status.
//                            }
//                        }
//        }
//        let paywall = await Apphud.paywall(ApphudPaywallID.onboarding.rawValue)
//        guard let product = paywall?.products[0] else { return }
//        let result = await Apphud.purchase(product)
    }
    
    private func checkIfSubscriptionCanceled() {
        if let date = UserDefaults.standard.object(forKey: "subscription_cancel_date") as? Date, let id = UserDefaults.standard.string(forKey: "subscription_cancel_id") {
            if Date() > date {
                UserDefaults.standard.set(nil, forKey: "subscription_cancel_date")
                EventTracker.shared.log(event: "subscription_canceled", with: ["subscription_id":id], and: [:])
            }
        }
        
    }
    
    private func setupAmplitude() {
        Amplitude.instance().trackingSessionEvents = true
            // Initialize SDK
        Amplitude.instance().initializeApiKey("")
        EventTracker.shared.log(event: "amplitude_initialized")
    }
    
    private func setupAppsFlyer() {
        AppsFlyerLib.shared().isDebug = true
        AppsFlyerLib.shared().appsFlyerDevKey = "<>"
        AppsFlyerLib.shared().appleAppID = "<>"
        NotificationCenter.default.addObserver(self, selector: NSSelectorFromString("sendLaunch"), name: UIApplication.didBecomeActiveNotification, object: nil)
        AppsFlyerLib.shared().waitForATTUserAuthorization(timeoutInterval: 60)
    }
    
    private func setupAppodeal() {
        Appodeal.setAutocache(true, types: .rewardedVideo)
        Appodeal.setAutocache(true, types: .interstitial)
        Appodeal.setLogLevel(.verbose)
        Appodeal.setInitializationDelegate(self)
        Appodeal.initialize(
            withApiKey: "",
            types: [.rewardedVideo, .banner, .interstitial, .MREC]
        )
        Appodeal.cacheAd(.MREC)
    }
    
    private func setupAffise(application: UIApplication,launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        let properties = AffiseInitProperties(affiseAppId: "", //Change to your app id
                                                      partParamName: "", //Change to your partParamName
                                                      partParamNameToken: "", //Change to your partParamNameToken
                                                      appToken: "", //Change to your appToken
                                                      isProduction: false, // Add your custom rule to determine if this is a production build
                                                      secretId: "" //Change to your appToken
                                                      )
        Affise.shared.load(app: application, initProperties: properties, launchOptions: launchOptions)
        Affise.shared.setTrackingEnabled(enabled: true)
        if #available(iOS 16.1, *) {
            AffiseSKAdNetwork.shared()?.updatePostbackConversionValue(0, coarseValue: "", completionHandler: { error in
                // Handle error
            })
        } else {
            if #available(iOS 15.4, *) {
                AffiseSKAdNetwork.shared()?.updatePostbackConversionValue(0, completionHandler: { error in
                    // Handle error
                })
            } else {
                AffiseSKAdNetwork.shared()?.registerAppForAdNetworkAttribution(completionHandler: { error in
                    // Handle error
                })

                AffiseSKAdNetwork.shared()?.updateConversionValue(0, completionHandler: { error in
                    // Handle error
                })
            }
        }
    }
    
    @objc func sendLaunch() {
       // AppsFlyerLib.shared().start()
        if #available(iOS 14, *) {
              ATTrackingManager.requestTrackingAuthorization { (status) in
                switch status {
                case .denied:
                    print("AuthorizationSatus is denied")
                case .notDetermined:
                    print("AuthorizationSatus is notDetermined")
                case .restricted:
                    print("AuthorizationSatus is restricted")
                case .authorized:
                    print("AuthorizationSatus is authorized")
                @unknown default:
                    fatalError("Invalid authorization status")
                }
              }
        }
    }

}

extension AppDelegate: AppodealInitializationDelegate {
    func appodealSDKDidInitialize() {
        
    }
}

