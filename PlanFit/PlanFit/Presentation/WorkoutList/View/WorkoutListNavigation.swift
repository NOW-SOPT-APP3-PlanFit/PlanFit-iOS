//
//  WorkoutListNavigation.swift
//  PlanFit
//
//  Created by 예삐 on 5/22/24.
//

import UIKit

import SnapKit

final class WorkoutListNavigation: UIView {
    
    // MARK: - UIComponent
    
    let backButton = UIButton()
    
    private let title = UILabel()
    
    private let shareButton = UIButton()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setViewHierarchy()
        setAutoLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI Setting

private extension WorkoutListNavigation {
    
    func setUI() {
        self.do {
            $0.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 48)
            $0.backgroundColor = .gray08BG
        }
        title.do {
            $0.setText("오늘의 추천 운동", font: .subtitle01, color: .gray01)
            $0.textAlignment = .center
        }
        backButton.do {
            $0.setImage(UIImage(named: "arrowLeft"), for: .normal)
        }
        shareButton.do {
            $0.setImage(UIImage(named: "share"), for: .normal)
        }
    }
    
    func setViewHierarchy() {
        addSubviews(title, backButton, shareButton)
    }
    
    func setAutoLayout() {
        title.snp.makeConstraints() {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        backButton.snp.makeConstraints() {
            $0.leading.equalToSuperview().offset(2)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(44)
        }
        shareButton.snp.makeConstraints() {
            $0.trailing.equalToSuperview().offset(-2)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(44)
        }
    }
}
