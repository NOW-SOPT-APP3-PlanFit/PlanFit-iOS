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
}
