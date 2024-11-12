//
//  DivKitManager.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 30.11.2022.
//

//import Foundation
////import DivKit
//import UIKit
//
//class DivKitManager {
//    
//    static let shared = DivKitManager()
//    
//    var components = DivKitComponents(
//        updateCardAction: nil,
//        urlOpener: DivKitURLOpener.shared.handle(url:)
//    )
//    
//    func setCard(_ card: DivData,at superview: UIView?) throws {
//      let context = components.makeContext(
//        cardId: DivCardID(rawValue: card.logId),
//        cachedImageHolders: []
//      )
//      let block = try card.makeBlock(context: context)
//      let view = block.reuse(
//        nil,
//        observer: nil,
//        overscrollDelegate: nil,
//        renderingDelegate: nil,
//        superview: superview
//      )
//    }
//    
//}
