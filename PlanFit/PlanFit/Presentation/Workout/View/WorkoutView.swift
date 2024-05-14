//
//  WorkoutView.swift
//  PlanFit
//
//  Created by 김진웅 on 5/14/24.
//

import UIKit

import SnapKit

class WorkoutView: UIView {
    
    // MARK: - UIComponent
    
    let currentTimeView = UIView()
    
    private let currentTimeOnAirDot = UIImageView()
    
    private let currentTimeLabel = UILabel()
    
    private let currentTimePlayImage = UIImageView()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setViewHierarchy()
        setAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UISetting

private extension WorkoutView {
    func setUI() {
        backgroundColor = .gray08BG
        
        currentTimeView.do {
            $0.backgroundColor = .none
            $0.layer.borderColor = UIColor.mainGreen.cgColor
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 15
        }
        
        currentTimeOnAirDot.do {
            $0.image = UIImage(resource: .onairDot)
        }
        
        currentTimeLabel.do {
            $0.setText("00:00:37", font: .subtitle01, color: .gray01)
        }
        
        currentTimePlayImage.do {
            $0.image = UIImage(resource: .play)
        }
    }
    
    func setViewHierarchy() {
        currentTimeView.addSubviews(currentTimeOnAirDot, currentTimeLabel, currentTimePlayImage)
    }
    
    func setAutoLayout() {
        currentTimeView.snp.makeConstraints {
            $0.width.equalTo(133)
            $0.height.equalTo(30)
        }
        
        currentTimeOnAirDot.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(16)
        }
        
        currentTimeLabel.snp.makeConstraints {
            $0.leading.equalTo(currentTimeOnAirDot.snp.trailing).offset(1)
            $0.centerY.equalToSuperview()
        }
        
        currentTimePlayImage.snp.makeConstraints {
            $0.leading.equalTo(currentTimeLabel.snp.trailing).offset(1)
            $0.trailing.equalToSuperview().offset(-11)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(16)
        }
    }
}
