//
//  ScreenResolutionsCategory.swift
//


import UIKit

enum UIDeviceSize: Int  {
    case h480 = 480 // 4
    case h568 = 568 // 5/SE
    case h667 = 667 // 8
    case h736 = 736 // 8+
    case h812 = 812 // 11Pro
    case h896 = 896 // 11/Max
    case unknown
}
    
enum UIDeviceCategory  {
    case lowRes // 3.5" 4"
    case middleRes // 4.7" 5.5"
    case highRes // 5.8" 6.1" 6.5"
    case ipadRes // iPad's
}

let deviceSize : UIDeviceSize = {
    let w: Double = Double(UIScreen.main.bounds.width)
    let h: Double = Double(UIScreen.main.bounds.height)
    let screenHeight: Double = max(w, h)
    
    switch screenHeight {
    case 480:
        return .h480
    case 568:
        return .h568
    case 667:
        return .h667
    case 736:
        return .h736
    case 812:
        return .h812
    case 896:
        return .h896
    default:
        return .unknown
    }
    
}()

let deviceCategory : UIDeviceCategory = {
    let w: Double = Double(UIScreen.main.bounds.width)
    let h: Double = Double(UIScreen.main.bounds.height)
    let screenHeight: Double = max(w, h)
    
    switch screenHeight {
    case 400...600:
        return .lowRes
    case 600...800:
        return .middleRes
    case 800...950:
        return .highRes
    case 950...1400:
        return .ipadRes
    default:
        return .middleRes
    }
}()

