//
//  EventTracker.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 13.04.2023.
//

import Foundation
import Amplitude
import AppsFlyerLib
import AffiseAttributionLib

class EventTracker {
    
    static let shared = EventTracker()
    
    func log(event: String) {
        Amplitude.instance().logEvent(event)
    }
    
    func log(event: String, with eventProperties: [String:String], and userProperties: [String:String]) {
        print(
        "[EventTracker] Event sent \n Name: \(event) \n Event Properties: \(eventProperties) \n User Properties: \(userProperties)"
        )
        Amplitude.instance().logEvent(event, withEventProperties: eventProperties, withUserProperties: userProperties)
        var appsFlyerValues = eventProperties
        appsFlyerValues.merge(dict: userProperties)
        AppsFlyerLib.shared().logEvent(event, withValues: appsFlyerValues)
    }
    
}
