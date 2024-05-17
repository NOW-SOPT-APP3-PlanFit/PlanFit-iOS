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
    
    private let goalBannerView = GoalBannerView()
    
    private let recommendPlanButton = UIButton()
    
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
        
        recommendPlanButton.do {
            var configuration = UIButton.Configuration.plain()
            configuration.baseForegroundColor = .gray01
            configuration.imagePlacement = .trailing
            configuration.imagePadding = 2
            $0.configuration = configuration
            $0.setTitle("체지방 감소 추천 플랜 (초급)", font: .subtitle01, titleColor: .gray01)
            $0.setImage(.arrowLeft, for: .normal)
        }
    }
    
    func setViewHierarchy() {
        addSubviews(goalBannerView, recommendPlanButton)
    }
    
    func setAutoLayout() {
        let safeArea = safeAreaLayoutGuide
        
        goalBannerView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(safeArea).inset(16)
        }
        
        recommendPlanButton.snp.makeConstraints {
            $0.top.equalTo(goalBannerView.snp.bottom).offset(36)
            $0.leading.equalToSuperview().offset(20)
        }
    }
}

