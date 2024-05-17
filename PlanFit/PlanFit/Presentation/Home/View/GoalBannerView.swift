//
//  GoalSectionView.swift
//  PlanFit
//
//  Created by 김진웅 on 5/17/24.
//

import UIKit

import SnapKit

final class GoalBannerView: BannerBackgroundView {
    
    // MARK: - UIComponent
    
    private let titleLabel = UILabel()
    
    private let tooltipImageView = UIImageView()
    
    private let titleStackView = UIStackView(axis: .horizontal)
    
    private let goalCountLabel = UILabel()
    
    private let totalCountLabel = UILabel()
    
    private let countStackView = UIStackView(axis: .horizontal)
    
    private let firstStampImageView = UIImageView()
    
    private let secondStampImageView = UIImageView()
    
    private let thirdStampImageView = UIImageView()
    
    private let imageStackView = UIStackView(axis: .horizontal)
    
    private let periodLabel = UILabel()
    
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

private extension GoalBannerView {
    func setUI() {        
        titleLabel.setText("이번 주 운동 목표는", font: .subtitle01, color: .gray01)
        
        tooltipImageView.do {
            $0.image = .tooltip
        }
    }
    
    func setViewHierarchy() {
        titleStackView.addArrangedSubviews(titleLabel, tooltipImageView)
        countStackView.addArrangedSubviews(goalCountLabel, totalCountLabel)
        imageStackView.addArrangedSubviews(firstStampImageView, secondStampImageView, thirdStampImageView)
        addSubviews(titleStackView, countStackView, imageStackView, periodLabel)
    }
    
    func setAutoLayout() {
        tooltipImageView.snp.makeConstraints {
            $0.size.equalTo(24)
        }
        
        titleStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(23)
        }
        
        goalCountLabel
    }
}

