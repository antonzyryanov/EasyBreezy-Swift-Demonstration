//
//  RoundedCornersView.swift

// Замена RoundedView, которое будет отрисовываться в дизайнере интерфейсов

import UIKit

/**
Состояние `RoundedCornersView` при интерактиве с пользователем.

 - selected: фиксация нажатия по форме.
 - deselected: обычное состояние формы.
*/
enum SelectionViewState {
    case selected
    case deselected
}

/**
Вид визуализации нажатия по `RoundedCornersView`.

 - shadowed: при нажатии происходит увеличение тени формы.
*/
enum ViewVisualizationType {
    case shadowed
    //case resizing
}

/// Форма со скругленными углами
@IBDesignable
class RoundedCornersView: UIView {

    // MARK: - Inspectable properties
    
    private var shadowOffset: CGSize = CGSize.zero
    
    /// Радиус скругления угла формы.
    @IBInspectable var cornerRadius: CGFloat = 0 {
       didSet {
           layer.cornerRadius = cornerRadius
           layer.masksToBounds = cornerRadius > 0
       }
    }
    @IBInspectable var shadowOffsetWidth: CGFloat = 0 {
       didSet {
           self.shadowOffset.width = shadowOffsetWidth
           layer.shadowOffset = self.shadowOffset
       }
    }
    @IBInspectable var shadowOffsetHeight: CGFloat = 0 {
       didSet {
           self.shadowOffset.height = shadowOffsetHeight
           layer.shadowOffset = self.shadowOffset
       }
    }
    /// Цвет тени
    @IBInspectable var shadowColor: UIColor = Color.black {
       didSet {
           layer.shadowColor = shadowColor.cgColor
       }
    }
    /// Размер тени формы.
    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet {
         //   layer.shadowColor = Color.black.cgColor
            layer.shadowOffset = CGSize(width: 6, height: 6)
            layer.shadowOpacity = 1.0
            layer.masksToBounds = shadowRadius < 1
            layer.shadowRadius = shadowRadius
        }
    }
    /// Ширина границы
    @IBInspectable var borderSize: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderSize
        }
    }
    /// Цвет границы
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    // MARK: - Properties
    private var viewState: SelectionViewState = .deselected
    private var shadowSelectionRaduisSize: CGFloat  {
        if deviceCategory == .lowRes {
            return 2
        } else {
            return 3
        }
    }
    
    // MARK: - Methods
    
    /// Визуализация нажатия.
    /// - Parameters:
    ///   - state: Состояние `SelectionViewState`.
    ///   - type: Тип визуализации `ViewVisualizationType`.
    func visualizeSelection(state: SelectionViewState, type: ViewVisualizationType) {
        switch state {
        case .selected:
            viewState = .selected
            
            switch type {
            case .shadowed:
                shadowRadius += shadowSelectionRaduisSize
            }
        case .deselected:
            if viewState == .selected {
                viewState = .deselected
                switch type {
                case .shadowed:
                    if shadowRadius > 0 {
                        shadowRadius -= shadowSelectionRaduisSize
                    }
                }
            }
        }
    }
    
}
