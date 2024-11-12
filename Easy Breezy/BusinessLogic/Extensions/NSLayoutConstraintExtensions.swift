//
//  NSLayoutConstraintExtensions.swift

import UIKit

/// Расширение `NSLayoutConstraint`
extension NSLayoutConstraint {
    
    /// Функция упрощенного создания `NSLayoutConstraint`
    /// - Parameters:
    ///   - item: Элемент привязки
    ///   - toItem: Элемент к которому осуществляется привязка
    ///   - attribute: Параметр привязки
    ///   - constant: Числовое значение привязки
    /// - Returns: Экземпляр класса `NSLayoutConstraint`
    static func simple(item: Any, toItem: Any?, attribute: Attribute, constant: CGFloat) -> NSLayoutConstraint{
        return NSLayoutConstraint(item: item,
                                  attribute: attribute,
                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                  toItem: toItem,
                                  attribute: attribute,
                                  multiplier: 1,
                                  constant: constant)
    }
    
    /// Функция упрощенного создания `NSLayoutConstraint`
    /// - Parameters:
    ///   - item: Элемент привязки
    ///   - toItem: Элемент к которому осуществляется привязка
    ///   - attribute: Параметр привязки
    ///   - toAttribute: Параметр к которому осуществляется привязка
    ///   - constant: Числовое значение привязки
    /// - Returns: Экземпляр класса `NSLayoutConstraint`
    static func simple(item: Any, toItem: Any?, attribute: Attribute, toAttribute: Attribute, constant: CGFloat) -> NSLayoutConstraint{
        return NSLayoutConstraint(item: item,
                                  attribute: attribute,
                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                  toItem: toItem,
                                  attribute: toAttribute,
                                  multiplier: 1,
                                  constant: constant)
    }
}


extension NSLayoutConstraint {
    /**
     Change multiplier constraint

     - parameter multiplier: CGFloat
     - returns: NSLayoutConstraint
    */
    func setMultiplier(multiplier:CGFloat) -> NSLayoutConstraint {

        NSLayoutConstraint.deactivate([self])

        let newConstraint = NSLayoutConstraint(
            item: firstItem,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)

        newConstraint.priority = priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier

        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
}
