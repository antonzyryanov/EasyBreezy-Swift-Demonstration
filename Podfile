source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '13.0'
use_frameworks!

source 'https://github.com/appodeal/CocoaPods.git'
source 'https://cdn.cocoapods.org/'

def appodeal
    pod 'Appodeal', '3.1.3'
    pod 'APDAdColonyAdapter', '3.1.3.0'
    pod 'BidMachineAdColonyAdapter', '~> 2.3.0.0'
    pod 'APDAppLovinAdapter', '3.1.3.1'
    pod 'APDBidMachineAdapter', '3.1.3.1' # Required
    pod 'BidMachineAmazonAdapter', '~> 2.3.0.0'
    pod 'BidMachineCriteoAdapter', '~> 2.3.0.0'
    pod 'BidMachineSmaatoAdapter', '~> 2.3.0.0'
    pod 'BidMachineTapjoyAdapter', '~> 2.3.0.0'
   # pod 'BidMachinePangleAdapter', '~> 2.3.0.0'
    pod 'APDFirebaseAdapter', '3.1.3.1'
    pod 'APDGoogleAdMobAdapter', '3.1.3.1'
    pod 'APDIABAdapter', '3.1.3.0' # Required
    pod 'APDIronSourceAdapter', '3.1.3.1'
    pod 'APDFacebookAdapter', '3.1.3.1'
    pod 'APDMetaAudienceNetworkAdapter', '3.1.3.0'
    pod 'BidMachineMetaAudienceAdapter', '~> 2.3.0.0'
    pod 'APDMyTargetAdapter', '3.1.3.1'
    pod 'BidMachineMyTargetAdapter', '~> 2.3.0.1'
    pod 'APDStackAnalyticsAdapter', '3.1.3.0' # Required
    pod 'APDUnityAdapter', '3.1.3.1'
    pod 'APDVungleAdapter', '3.1.3.1'
    pod 'BidMachineVungleAdapter', '~> 2.3.0.1'
    pod 'APDYandexAdapter', '3.1.3.0'
    pod 'BidMachineMintegralAdapter', '~> 2.3.0.2'
end

inhibit_all_warnings!

target 'Easy Breezy' do

  project 'Easy Breezy.xcodeproj'
  appodeal

  # Reactive Programming in Swift
 # pod 'RxSwift', '~> 6.5'
 # pod 'RxCocoa', '~> 6.5'
 # pod 'RxRelay', '~> 6.5'
 # pod 'RxSwiftUtilities', :path => 'libraries/RxSwiftUtilities/'
 # pod 'RxAlertController', '~> 6.0'

  # Elegant HTTP Networking in Swift
 # pod 'Alamofire', '~> 5.4'
  #pod 'AlamofireNetworkActivityLogger', '~> 3.4'
  #pod 'AlamofireNetworkActivityIndicator', '~> 3.1'

  # Beautiful flag icons for usage in apps and on the web.
  #pod 'FlagKit', :path => 'libraries/FlagKit/'

  # A clean and lightweight progress HUD for your iOS and tvOS app.
  #pod 'SVProgressHUD', '~> 2.2'

  # A lightweight, pure-Swift library for downloading and caching images from the web.
  pod 'Kingfisher', '~> 7.4'

  # Firebase
  pod 'Firebase/Core', '~> 10.3'
  pod 'FirebaseCrashlytics', '~> 10.3'
  pod 'Firebase/Messaging', '~> 10.3'

  # Facebook Analytics

  # Notify users when a new version of your app is available and prompt them to upgrade.
  pod 'Siren', '~> 5.8'

  # An iOS library to natively render After Effects vector animations.
  pod 'lottie-ios', '~> 4.0'

  # Tasteful Checkbox for iOS. (Check box)
  #pod 'BEMCheckBox', :path => 'libraries/BEMCheckBox/'

  # Device detect the current device model and screen size.
  #pod 'Device', '~> 3.2'

  pod 'Amplitude', '~> 8.14'
  pod 'SDWebImage', '~> 5.0'
  pod 'Alamofire'
  pod 'ApphudSDK', '~> 3.0'

  # AdMob
  #pod 'Google-Mobile-Ads-SDK', '~> 9.14'

  # AppsFlyer Apple SDK
  pod 'AppsFlyerFramework', '~> 6.9'

  # Yandex AppMetrica
  #pod 'YandexMobileMetrica/Dynamic', '~> 4.4'
  # Affise
  pod 'AffiseAttributionLib', '~> 1.1.6'
  pod 'AffiseSKAdNetwork', '~> 1.1.5'
  pod 'GoogleSignIn'

  pod 'SideMenu'
  #pod 'SlideMenuControllerSwift'
  pod 'LGSideMenuController'
end


post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
            end
        end
    end
end







