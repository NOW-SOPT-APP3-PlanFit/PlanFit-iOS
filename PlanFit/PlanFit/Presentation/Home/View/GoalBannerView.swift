//
//  GoalBannerView.swift
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
    
    private let firstStampButton = StampButton()
    
    private let secondStampButton = StampButton()
    
    private let thirdStampButton = StampButton()
    
    private let stampStackView = UIStackView(axis: .horizontal)
    
    private let periodLabel = UILabel()
    
    // MARK: - Property
    
    private lazy var stampButtons = [firstStampButton, secondStampButton, thirdStampButton]
    
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

private extension GoalBannerView {
    func setUI() {        
        titleLabel.do {
            $0.setText("이번 주 운동 목표는", font: .subtitle01, color: .gray01)
        }
        
        tooltipImageView.do {
            $0.image = .tooltip
        }
        
        goalCountLabel.do {
            $0.setText("1", font: .subtitle01, color: .gray01)
        }
        
        totalCountLabel.do {
            $0.setText(" / 3회", font: .subtitle01, color: .gray04)
        }
        
        firstStampButton.do {
            $0.activate()
        }
        
        stampStackView.do {
            $0.spacing = 4
        }
        
        periodLabel.do {
            $0.setText("2024.04.22. ~ 04.28.", font: .caption02, color: .gray04)
        }
    }
    
    func setViewHierarchy() {
        titleStackView.addArrangedSubviews(titleLabel, tooltipImageView)
        countStackView.addArrangedSubviews(goalCountLabel, totalCountLabel)
        stampStackView.addArrangedSubviews(firstStampButton, secondStampButton, thirdStampButton)
        addSubviews(titleStackView, countStackView, stampStackView, periodLabel)
    }
    
    func setAutoLayout() {
        tooltipImageView.snp.makeConstraints {
            $0.size.equalTo(24)
        }
        
        titleStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(23)
        }
        
        countStackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalTo(titleStackView)
        }
        
        stampStackView.snp.makeConstraints {
            $0.top.equalTo(titleStackView.snp.bottom).offset(16)
            $0.leading.bottom.equalToSuperview().inset(23)
            $0.height.equalTo(Screen.height(50))
        }
        
        periodLabel.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().inset(15)
        }
    }
}
