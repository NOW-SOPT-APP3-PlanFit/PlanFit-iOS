//
//  UILabel+.swift
//  PlanFit
//
//  Created by 김진웅 on 5/14/24.
//

import UIKit

extension UILabel {
    func setText(_ text: String, font: UIFont.NeoFont, color: UIColor) {
        self.attributedText = .neoAttributedString(for: font, with: text)
        self.textColor = color
    }
    func setLineSpacing(lineSpacing: CGFloat) {
        if let text = self.text {
            let attributedStr = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()
            style.lineSpacing = lineSpacing
            attributedStr.addAttribute(
                NSAttributedString.Key.paragraphStyle,
                value: style,
                range: NSRange(location: 0, length: attributedStr.length))
            self.attributedText = attributedStr
        }
    }
}
