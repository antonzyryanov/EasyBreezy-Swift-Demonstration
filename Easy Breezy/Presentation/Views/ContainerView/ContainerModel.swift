//
//  ContainerModel.swift

import UIKit

struct ContainerModel {
    struct Settings {
        var leadingOffset: CGFloat = 0
        var trailingOffset: CGFloat = 0
        var topOffset: CGFloat = 0
        var bottomOffset: CGFloat = 0
        var componentsOffset: CGFloat = 0
    }
    
    struct Priorities {
        var componentHeight: Float = 1000
    }
    
    var views = [ContainerViewSupporting]()
    var settings = Settings()
    var priorities = Priorities()
    var isFunnel: Bool = false
}
