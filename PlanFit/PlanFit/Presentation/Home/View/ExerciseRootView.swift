//
//  ExerciseRootView.swift
//  PlanFit
//
//  Created by 김진웅 on 5/14/24.
//

import UIKit

import SnapKit

final class ExerciseRootView: UIView {
    
    // MARK: - UIComponent
    
    private let goalBannerView = GoalBannerView()
    
    private let recommendPlanButton = UIButton()
    
    private let startExerciseBannerView = StartExerciseBannerView()
    
    private let lineImageView = UIImageView()
    
    private let exerciseInfoBannerView = ExerciseInfoBannerView()
    
    private let aiButton = UIButton()
    
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

private extension ExerciseRootView {
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
        
        lineImageView.do {
            $0.image = UIImage(resource: .line).withRenderingMode(.alwaysOriginal)
        }
        
        aiButton.do {
            let image = UIImage(resource: .ai).withRenderingMode(.alwaysOriginal)
            $0.setImage(image, for: .normal)
        }
    }
    
    func setViewHierarchy() {
        addSubviews(
            goalBannerView, recommendPlanButton, startExerciseBannerView, lineImageView, exerciseInfoBannerView,
            aiButton
        )
        bringSubviewToFront(lineImageView)
        bringSubviewToFront(aiButton)
    }
    
    func setAutoLayout() {
        let safeArea = safeAreaLayoutGuide
        
        goalBannerView.snp.makeConstraints {
            $0.top.equalTo(safeArea).offset(40)
            $0.leading.trailing.equalTo(safeArea).inset(16)
        }
        
        recommendPlanButton.snp.makeConstraints {
            $0.top.equalTo(goalBannerView.snp.bottom).offset(36)
            $0.leading.equalToSuperview().offset(20)
        }
        
        startExerciseBannerView.snp.makeConstraints {
            $0.top.equalTo(recommendPlanButton.snp.bottom).offset(12)
            $0.leading.trailing.equalTo(goalBannerView)
        }
        
        lineImageView.snp.makeConstraints {
            $0.top.equalTo(startExerciseBannerView.snp.bottom).offset(-5)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Screen.width(12))
            $0.height.equalTo(Screen.height(40))
        }
        
        exerciseInfoBannerView.snp.makeConstraints {
            $0.top.equalTo(lineImageView.snp.bottom).offset(-5)
            $0.leading.trailing.equalTo(startExerciseBannerView)
        }
        
        aiButton.snp.makeConstraints {
            $0.bottom.equalTo(safeArea).offset(-10)
            $0.trailing.equalToSuperview().offset(-39)
        }
    }
}

