//
//  UIButton+.swift
//  PlanFit
//
//  Created by 김진웅 on 5/14/24.
//

import UIKit

extension UIButton {
    func setTitle(_ title: String, font: UIFont.NeoFont, titleColor: UIColor) {
        setAttributedTitle(.neoAttributedString(for: font, with: title), for: .normal)
        setTitleColor(titleColor, for: .normal)
    }
    
    func setLayer(borderWidth: CGFloat = 0, borderColor: UIColor, cornerRadius: CGFloat) {
        layer.borderColor = borderColor.cgColor
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
    }
    
    func addUnderline() {
        let attributedString = NSMutableAttributedString(string: self.titleLabel?.text ?? "")
        attributedString.addAttribute(
            .underlineStyle,
            value: NSUnderlineStyle.single.rawValue,
            range: NSRange(location: 0, length: attributedString.length)
        )
        setAttributedTitle(attributedString, for: .normal)
    }
}
