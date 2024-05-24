//
//  UIFont+.swift
//  PlanFit
//
//  Created by 김진웅 on 5/14/24.
//

import UIKit

extension UIFont {
    static func neoFont(for type: NeoFont) -> UIFont {
        return UIFont(name: type.weight, size: type.size) ?? .systemFont(ofSize: type.size)
    }
}

extension UIFont {
    enum NeoFont {
        case head01, head02, head03, head04, head05
        case subtitle01, subtitle02B, subtitle02
        case body01B, body01
        case caption01, caption02, caption03
        
        var size: CGFloat {
            switch self {
            case .head01: 30
            case .head02: 26
            case .head03: 24
            case .head04: 23
            case .head05: 20
                
            case .subtitle01: 18
            case .subtitle02B, .subtitle02: 16
                
            case .body01B, .body01: 14
                
            case .caption01: 13
            case .caption02: 12
            case .caption03: 11
            }
        }
        
        var weight: String {
            switch self {
            case .head01, .head02, .head03, .head04, .head05: "AppleSDGothicNeo-Bold"
                
            case .subtitle01, .subtitle02B: "AppleSDGothicNeo-Bold"
            case .subtitle02: "AppleSDGothicNeo-Regular"
                
            case .body01B: "AppleSDGothicNeo-Bold"
            case .body01: "AppleSDGothicNeo-Regular"
                
            case .caption01, .caption02, .caption03: "AppleSDGothicNeo-Regular"
            }
        }
        
        var kern: CGFloat {
            CGFloat(kernRatio) / 100 * size
        }
        
        private var kernRatio: Int {
            switch self {
            case .head01, .head05: 0
            case .head02: -1
            case .head03, .head04: -4
                
            case .subtitle01, .subtitle02: 1
            case .subtitle02B: 0
                
            case .body01B, .body01: 0
                
            case .caption01: -3
            case .caption02, .caption03: 0
            }
        }
    }
}
