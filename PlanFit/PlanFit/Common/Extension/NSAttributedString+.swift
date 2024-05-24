//
//  NSAttributedString+.swift
//  PlanFit
//
//  Created by 김진웅 on 5/14/24.
//

import UIKit

extension NSAttributedString {
    static func neoAttributedString(for type: UIFont.NeoFont, with string: String = "") -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.neoFont(for: type),
            .kern: type.kern
        ]
        return NSAttributedString(string: string, attributes: attributes)
    }
}
