//
//  ContainerView.swift

import UIKit

protocol ContainerViewSupporting: UIView {
    var heightInContainer: CGFloat { get set }
}

/// Универсальный контейнер для последовательного списка UIView
class ContainerView: UIView {
    
    // MARK: - Properties
    
    private var model = ContainerModel()

    // MARK: - Methods

    func configure(with model: ContainerModel) {
        self.model = model
        renderViews()
    }
    
    private func renderViews() {
        model.views.enumerated().forEach { (index, item) in
            self.addSubview(item)
            
            item.translatesAutoresizingMaskIntoConstraints = false
            
            var leadingConstraint = NSLayoutConstraint.simple(item: item, toItem: self, attribute: .leading, constant: model.settings.leadingOffset)
            var trailingConstraint = NSLayoutConstraint.simple(item: item, toItem: self, attribute: .trailing, constant: -model.settings.trailingOffset)
            if model.isFunnel {
                leadingConstraint = NSLayoutConstraint.simple(item: item, toItem: self, attribute: .leading, constant: model.settings.leadingOffset + CGFloat(index*16))
                trailingConstraint = NSLayoutConstraint.simple(item: item, toItem: self, attribute: .trailing, constant: -model.settings.trailingOffset - CGFloat(index*16))
            }
            let heightConstraint = NSLayoutConstraint.simple(item: item, toItem: nil, attribute: .height, toAttribute: .notAnAttribute, constant: item.heightInContainer)
            heightConstraint.priority = .init(rawValue: model.priorities.componentHeight)

            self.addConstraints([leadingConstraint, trailingConstraint, heightConstraint])
            
            // Первый элемент
            if index == 0 {
                let topConstraint = NSLayoutConstraint.simple(item: item, toItem: self, attribute: .top, constant: model.settings.topOffset)
                self.addConstraints([topConstraint])
                
                if model.views.count == 1 {
                    let bottomConstraint = NSLayoutConstraint.simple(item: item, toItem: self, attribute: .bottom, constant: model.settings.bottomOffset)
                    self.addConstraints([bottomConstraint])
                }
            }
            
            // Оставшиеся, кроме первого
            if index+1 <= model.views.count && model.views.count > 1 && index > 0 {
                let topConstraint = NSLayoutConstraint.simple(item: item, toItem: model.views[index-1], attribute: .top, toAttribute: .bottom, constant: model.settings.componentsOffset)
                self.addConstraints([topConstraint])
                
                // Последний элемент
                if index+1 == model.views.count {
                    let bottomConstraint = NSLayoutConstraint.simple(item: item, toItem: self, attribute: .bottom, constant: model.settings.bottomOffset)
                    self.addConstraints([bottomConstraint])
                }
            }
        }
    }

    func clear() {
        removeAllSubviews()
    }
    
}
