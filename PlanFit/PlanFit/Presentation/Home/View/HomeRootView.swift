//
//  HomeView.swift
//  PlanFit
//
//  Created by 김진웅 on 5/14/24.
//

import UIKit

final class HomeView: UIView {
    
    // MARK: - UIComponent
    
    
    // MARK: - Property
    
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setUI()
        setViewHierarchy()
        setAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Action
    
    
}

// MARK: - UISetting

private extension HomeView {
    
    func setUI() {
        backgroundColor = .gray08BG
    }
    
    func setViewHierarchy() {
        
    }
    
    func setAutoLayout() {
        
    }
}

