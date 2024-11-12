//
//  UIView+XibLoadable.swift

import UIKit

/// Протокол загрузчика xib файлов
protocol XibLoadable {
    static var nibName: String { get }
    func customizeView()
}

/// Расширение `UIView` с поддержкой загрузки данных из xib файлов
extension XibLoadable where Self: UIView {
    
    /// Имя файла xib
    static var nibName: String {
        return String(describing: Self.self)
    }

    /// Представление xib в виде объекта UINib
    static var nib: UINib {
        let bundle = Bundle(for: Self.self)
        return UINib(nibName: Self.nibName, bundle: bundle)
    }
    
    /// Параметр установки цвета UIView, которую загрузили из xib файла
    var backgroundColorXib: UIColor {
        set {
            if !self.subviews.isEmpty {
                self.subviews[0].backgroundColor = newValue
            }
        }
        get {
            if !self.subviews.isEmpty {
                return self.subviews[0].backgroundColor ?? .white
            } else {
                return .white
            }
        }
    }
    
    /// Загрузка xib для отображения
    func setupFromXib() {
        guard let view = Self.nib.instantiate(withOwner: self, options: nil).first as? UIView else { fatalError("Error loading \(self) from nib") }
        view.frame = self.bounds
        self.backgroundColor = .clear
        addSubview(view)
        self.customizeView()
    }
    
    /// Функция дополнительной настройки формы
    func customizeView() { }
    
//    func applyXib(style: ViewStyle?) {
//        if !self.subviews.isEmpty {
//            self.subviews[0].apply(style: style)
//        } else {
//            self.apply(style: style)
//        }
//    }
}
