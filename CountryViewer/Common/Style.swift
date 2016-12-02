//
//  Style.swift
//  CountryViewer
//
//  Created by Konrad on 02.12.2016.
//  Copyright © 2016 KonradDawid. All rights reserved.
//

import UIKit


extension UIButton {
    
    func applyNormalStyle() {
        applyCommonStyle()
        setTitleColor(Constants.Style.defaultTextColor, for: .normal)
        backgroundColor = Constants.Style.defaultButtonColor
        layer.borderColor = Constants.Style.defaultBorderColor.cgColor
    }
    
    func applyWarningStyle() {
        applyCommonStyle()
        setTitleColor(Constants.Style.warningTextColor, for: .normal)
        backgroundColor = Constants.Style.warningButtonColor
        layer.borderColor = Constants.Style.warningBorderColor.cgColor
    }
    
    func applyCommonStyle() {
        titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: FontWeight.regular.value)
        layer.cornerRadius = 5.0
        layer.borderWidth = 1.0
    }
}

extension UILabel {
    
    func applyStyle() {
        self.textColor = Constants.Style.defaultTextColor
        self.backgroundColor = UIColor.clear
    }
}

enum FontWeight: CGFloat {
    case light
    case regular
    case bold
    
    var value: CGFloat {
        switch self {
        case .light: return UIFontWeightLight
        case .regular: return UIFontWeightRegular
        case .bold: return UIFontWeightBold
        }
    }
}

extension UILabel {
    static func styledLabel(size: CGFloat = 16.0, weight: FontWeight = .regular) -> UILabel {
        let label = UILabel(frame: CGRect.zero)
        label.font = UIFont.systemFont(ofSize: size, weight: weight.value)
        label.applyStyle()
        return label
    }
}

enum ButtonStyle {
    case normal, warning
}

extension UIButton {
    static func withStyle(_ buttonStyle: ButtonStyle = .normal) -> UIButton {
        let button = UIButton(frame: CGRect.zero)
        switch buttonStyle {
        case .normal:
            button.applyNormalStyle()
        case .warning:
            button.applyWarningStyle()
        }
        return button
    }
}

