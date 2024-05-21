//
//  BannerBackgroundView.swift
//  PlanFit
//
//  Created by 김진웅 on 5/17/24.
//

import UIKit

class BannerBackgroundView: UIView {
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UISetting

private extension BannerBackgroundView {
    func setUI() {
        backgroundColor = .gray07
        layer.cornerRadius = 15
    }
}
