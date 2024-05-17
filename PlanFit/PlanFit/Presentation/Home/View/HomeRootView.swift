//
//  HomeRootView.swift
//  PlanFit
//
//  Created by 김진웅 on 5/14/24.
//

import UIKit

import SnapKit

final class HomeRootView: UIView {
    
    // MARK: - UIComponent
    
    private let goalSectionView = GoalBannerView()
    
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
}

// MARK: - UISetting

private extension HomeRootView {
    func setUI() {
        backgroundColor = .gray08BG
    }
    
    func setViewHierarchy() {
        addSubviews(goalSectionView)
    }
    
    func setAutoLayout() {
        let safeArea = safeAreaLayoutGuide
        
        goalSectionView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(safeArea).inset(16)
        }
    }
}

