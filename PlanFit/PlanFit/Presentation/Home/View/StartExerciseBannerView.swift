//
//  StartExerciseBannerView.swift
//  PlanFit
//
//  Created by 김진웅 on 5/17/24.
//

import UIKit

import SnapKit

final class StartExerciseBannerView: BannerBackgroundView {
    
    // MARK: - UIComponent
    
    private let firstExplanationLabel = UILabel()
    
    private let sessionsDropDownButton = DropDownButton()
    
    private let secondExplanationLabel = UILabel()
    
    private let firstContentStackView = UIStackView(axis: .horizontal)
    
    private let minutesDropDownButton = DropDownButton()
    
    private let thirdExplanationLabel = UILabel()
    
    private let secondContentStackView = UIStackView(axis: .horizontal)
    
    private let conditionsDropDownButton = DropDownButton()
    
    private let lastExplanationLabel = UILabel()
    
    private let thirdContentStackView = UIStackView(axis: .horizontal)
    
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

private extension StartExerciseBannerView {
    func setUI() {
        firstExplanationLabel.do {
            $0.setText("주 2회 운동 중", font: .subtitle02B, color: .gray02)
        }
        
        sessionsDropDownButton.do {
            $0.setTitle("2회차", font: .subtitle02B, titleColor: .mainGreen)
        }
        
        secondExplanationLabel.do {
            $0.setText("루틴,", font: .subtitle02B, color: .gray02)
        }
        
        minutesDropDownButton.do {
            $0.setTitle("58분", font: .subtitle02B, titleColor: .mainGreen)
        }
        
        thirdExplanationLabel.do {
            $0.setText("만큼 운동,", font: .subtitle02B, color: .gray02)
        }
        
        conditionsDropDownButton.do {
            $0.setTitle("최상", font: .subtitle02B, titleColor: .mainGreen)
        }
        
        lastExplanationLabel.do {
            $0.setText("의 컨디션", font: .subtitle02B, color: .gray02)
        }
        
        [firstContentStackView, secondContentStackView, thirdContentStackView].forEach {
            $0.spacing = 8
        }
    }
    
    func setViewHierarchy() {
        firstContentStackView.addArrangedSubviews(
            firstExplanationLabel, sessionsDropDownButton, secondExplanationLabel
        )
        secondContentStackView.addArrangedSubviews(
            minutesDropDownButton, thirdExplanationLabel
        )
        thirdContentStackView.addArrangedSubviews(
            conditionsDropDownButton, lastExplanationLabel
        )
        addSubviews(firstContentStackView, secondContentStackView, thirdContentStackView)
    }
    
    func setAutoLayout() {
        firstContentStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(24)
        }
        
        secondContentStackView.snp.makeConstraints {
            $0.top.equalTo(firstContentStackView.snp.bottom).offset(10)
            $0.leading.equalTo(firstContentStackView)
            $0.bottom.equalToSuperview().offset(-16)
        }
        
        thirdContentStackView.snp.makeConstraints {
            $0.top.bottom.equalTo(secondContentStackView)
            $0.leading.equalTo(secondContentStackView.snp.trailing).offset(17)
        }
    }
}

