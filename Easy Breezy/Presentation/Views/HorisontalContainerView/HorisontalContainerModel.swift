//
//  HorisontalContainerModel.swift

import UIKit

protocol HorisontalContainerViewSupporting: UIView {
    var widthInContainer: CGFloat { get set }
}

struct HorisontalContainerModel {
    struct Settings {
        var topOffset: CGFloat = 0
        var bottomOffset: CGFloat = 0
        var leftOffset: CGFloat = 0
        var rightOffset: CGFloat = 0
        var componentsOffset: CGFloat = 0
    }
    
    struct Priorities {
        var componentWidth: Float = 1000
    }
    
    var views = [HorisontalContainerViewSupporting]()
    var settings = Settings()
    var priorities = Priorities()
}
