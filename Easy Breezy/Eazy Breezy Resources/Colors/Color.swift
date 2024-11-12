//
//  Color.swift

import UIKit

enum Color {

    // MARK: - Common

    static let white = UIColor.white
    static let black = UIColor.black
    static let customBlack = UIColor(red:0.09, green:0.09, blue:0.09, alpha:1)
    static let turquoise = UIColor(red:0.22, green:0.68, blue:0.7, alpha:1)
    static let turquoise2 = UIColor(red:0, green:0.62, blue:0.64, alpha:1)
    static let darkGrey = UIColor(red:0.59, green:0.59, blue:0.59, alpha:1)
    static let grey = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1)
    static let systemGray = UIColor.gray
    static let customGray = UIColor(red: 250.0/255.0, green: 250.0/255.0, blue: 250.0/255.0, alpha: 1.0)
    static let semiDarkGray = UIColor(red:0.91, green:0.92, blue:0.93, alpha:1)
    static let tableViewBackgroundCell = Color.customGray
    static let cardInsideContentLight = Color.white
    static let cardInsideContentDark = Color.customBlack
    static let customRed = UIColor(red:0.85, green:0.28, blue:0.38, alpha:1)
    static let customOrange = UIColor(red:1, green:0.73, blue:0.06, alpha:0.5)

    // MARK: - Login

    static let cloudyWhite = UIColor.white.withAlphaComponent(0.3)
    static let loginGray = UIColor.gray
    static let loginForgot = UIColor(red:0.59, green:0.59, blue:0.59, alpha:1)
    static let cloudyTurquoise = Color.turquoise.withAlphaComponent(0.5)
    static let loginTextfield = Color.customBlack
    static let loginTextFieldLabel = loginForgot

    // MARK: - InputPin

    static let InputPinTitle = UIColor(red:0.56, green:0.56, blue:0.58, alpha:1)
    static let InputPinCircle = UIColor(red:0.8, green:0.8, blue:0.8, alpha:1)
    static let InputPinCircleHightLighted = UIColor(red:0.22, green:0.68, blue:0.7, alpha:1)
    static let PinCodeHighLighted = UIColor(red:0.22, green:0.68, blue:0.7, alpha:0.3)
    static let PinCodeNumberHighLighted = Color.turquoise
    static let PinCodeNumber = Color.customBlack

    // MARK: - Tab Bar

    static let TabBar_TintColor = Color.turquoise // цвет изображения в активном режиме
    static let TabBar_SelectedText = UIColor(red:0.14, green:0.24, blue:0.25, alpha:1)
    static let TabBar_BackgroundColor = Color.white.withAlphaComponent(0.5)

    // MARK: -  Textfield

    static let SearchTextfield = Color.customBlack
    static let SearchTextfieldBackground = Color.semiDarkGray

    // MARK: - Bank

    static let bankInfoLabel = UIColor(red:0.18, green:0.18, blue:0.18, alpha:1)
    static let bankTurquoise = Color.turquoise2

    // MARK: - History

    static let orangeColor = UIColor(red:1, green:0.73, blue:0.05, alpha:1)
    static let lightOrangeColor = UIColor(red:1, green:0.92, blue:0.72, alpha:1)
    static let paymentIconOrange = UIColor(red:0.96, green:0.79, blue:0.36, alpha:1)

    // MARK: - Products

    static let productsOrange = #colorLiteral(red: 1, green: 0.7294117647, blue: 0.05882352941, alpha: 1)
    static let insuranceTurquoise = #colorLiteral(red: 0.5254901961, green: 0.7254901961, blue: 0.8509803922, alpha: 1)
    
    // MARK: - Header Collection View Label
    
    static let collectionViewCellLabel = #colorLiteral(red: 0.2235294118, green: 0.2235294118, blue: 0.2235294118, alpha: 1)
}
