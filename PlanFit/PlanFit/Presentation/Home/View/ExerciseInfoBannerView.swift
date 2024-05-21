//
//  ExerciseInfoBannerView.swift
//  PlanFit
//
//  Created by 김진웅 on 5/17/24.
//

import UIKit

import SnapKit

final class ExerciseInfoBannerView: BannerBackgroundView {
    
    // MARK: - UIComponent
    
    private let titleLabel = UILabel()
    
    private let explanationLabel = UILabel()
    
    private let exerciseCountItem = InfoItemView()
    
    private let setCountItem = InfoItemView()
    
    private let caloriesItem = InfoItemView()
    
    private let infoItemStackView = UIStackView(axis: .horizontal)
    
    let startExerciseButton = UIButton()
    
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

private extension ExerciseInfoBannerView {
    func setUI() {
        titleLabel.do {
            $0.setText("운동 부위", font: .body01B, color: .gray02)
        }
        
        explanationLabel.do {
            $0.setText("등, 가슴, 어깨, 하체, 이두, 유산소", font: .body01, color: .gray02)
        }
        
        exerciseCountItem.do {
            $0.configure(image: .dumbbell, text: "6개의 운동")
        }
        
        setCountItem.do {
            $0.configure(image: .set, text: "21세트")
        }
        
        caloriesItem.do {
            $0.configure(image: .fire, text: "641kcal")
        }
        
        infoItemStackView.do {
            $0.spacing = 41
            $0.distribution = .fillEqually
        }
        
        startExerciseButton.do {
            $0.setTitle("추천 운동 시작하기", font: .subtitle01, titleColor: .gray10)
            $0.backgroundColor = .mainGreen
            $0.layer.cornerRadius = 15
        }
    }
    
    func setViewHierarchy() {
        infoItemStackView.addArrangedSubviews(exerciseCountItem, setCountItem, caloriesItem)
        addSubviews(titleLabel, explanationLabel, infoItemStackView, startExerciseButton)
    }
    
    func setAutoLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(21)
            $0.leading.equalToSuperview().offset(27)
        }
        
        explanationLabel.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(9)
        }
        
        infoItemStackView.snp.makeConstraints {
            $0.top.equalTo(explanationLabel.snp.bottom).offset(25)
            $0.centerX.equalToSuperview()
        }
        
        startExerciseButton.snp.makeConstraints {
            $0.top.equalTo(infoItemStackView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(Screen.height(48))
            $0.bottom.equalToSuperview().offset(-24)
        }
    }
}

