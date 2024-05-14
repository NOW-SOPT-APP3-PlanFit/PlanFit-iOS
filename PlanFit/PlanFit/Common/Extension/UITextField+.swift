//
//  UITextField+.swift
//  PlanFit
//
//  Created by 김진웅 on 5/14/24.
//

import UIKit

extension UITextField {
    func addPadding(left: CGFloat? = nil, right: CGFloat? = nil) {
        if let left {
            leftView = UIView(frame: CGRect(x: 0, y: 0, width: left, height: 0))
            leftViewMode = .always
        }
        if let right {
            rightView = UIView(frame: CGRect(x: 0, y: 0, width: right, height: 0))
            rightViewMode = .always
        }
    }
    
    func setText(
        placeholder: String,
        textColor: UIColor,
        backgroundColor: UIColor,
        placeholderColor: UIColor,
        font: UIFont.NeoFont
    ) {
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: placeholderColor, .font: font, .kern: font.kern]
        )
        self.attributedText = .neoAttributedString(for: font)
    }
    
    func setAutoType(
        autocapitalizationType: UITextAutocapitalizationType = .none,
        autocorrectionType: UITextAutocorrectionType = .no
    ) {
        self.autocapitalizationType = autocapitalizationType
        self.autocorrectionType = autocorrectionType
    }
    
    func setLayer(
        borderWidth: CGFloat = 0, borderColor: UIColor, cornerRadius: CGFloat) {
        layer.borderColor = borderColor.cgColor
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
    }
}
