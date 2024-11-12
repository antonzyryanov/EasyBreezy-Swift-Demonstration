//
//  HorisontalContainerView.swift

import UIKit

protocol HorisnotalContainerViewSupporting: UIView {
    var heightInContainer: CGFloat { get set }
}

/// Универсальный контейнер для последовательного списка UIView
class HorisontalContainerView: UIView {
    
    // MARK: - Properties
    
    private var model = HorisontalContainerModel()

    // MARK: - Methods

    func configure(with model: HorisontalContainerModel) {
        self.model = model
        renderViews()
    }
    
    private func renderViews() {
        model.views.enumerated().forEach { (index, item) in
            self.addSubview(item)
            
            item.translatesAutoresizingMaskIntoConstraints = false
            
            var topConstraint = NSLayoutConstraint.simple(item: item, toItem: self, attribute: .top, constant: model.settings.topOffset)
            var bottomConstraint = NSLayoutConstraint.simple(item: item, toItem: self, attribute: .bottom, constant: -model.settings.bottomOffset)
            let widthConstraint = NSLayoutConstraint.simple(item: item, toItem: nil, attribute: .width, toAttribute: .notAnAttribute, constant: item.widthInContainer)
            widthConstraint.priority = .init(rawValue: model.priorities.componentWidth)

            self.addConstraints([topConstraint, bottomConstraint, widthConstraint])
            
            // Первый элемент
            if index == 0 {
                let leadingConstraint = NSLayoutConstraint.simple(item: item, toItem: self, attribute: .leading, constant: model.settings.leftOffset)
                self.addConstraints([leadingConstraint])
                
                if model.views.count == 1 {
                    let trailingConstraint = NSLayoutConstraint.simple(item: item, toItem: self, attribute: .trailing, constant: -model.settings.rightOffset)
                    self.addConstraints([trailingConstraint])
                }
            }
            
            // Оставшиеся, кроме первого
            if index+1 <= model.views.count && model.views.count > 1 && index > 0 {
                let leadingConstraint = NSLayoutConstraint.simple(item: item, toItem: model.views[index-1], attribute: .leading, toAttribute: .trailing, constant: model.settings.componentsOffset)
                self.addConstraints([leadingConstraint])
                
                // Последний элемент
                if index+1 == model.views.count {
                    let trailingConstraint = NSLayoutConstraint.simple(item: item, toItem: self, attribute: .trailing, constant: -model.settings.rightOffset)
                    self.addConstraints([trailingConstraint])
                }
            }
        }
    }

    func clear() {
        removeAllSubviews()
    }
    
}
