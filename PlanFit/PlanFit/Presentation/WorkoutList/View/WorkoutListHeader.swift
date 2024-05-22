//
//  WorkoutListHeader.swift
//  PlanFit
//
//  Created by 예삐 on 5/22/24.
//

import UIKit

import SnapKit

final class WorkoutListHeader: UIView {
    
    // MARK: - UIComponent
    
    private let headerSeperator = UIImageView()
    
    private let totalNumberLabel = UILabel()
    
    private let totalTimeIcon = UIImageView()
    
    private let totalTimeLabel = UILabel()
    
    private let superSetIcon = UIImageView()
    
    private let superSetLabel = UILabel()
    
    private let superSetSwitch = UISwitch()
    
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

private extension WorkoutListHeader {
    
    private func setUI() {
        self.do {
            $0.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 44)
        }
        headerSeperator.do {
            $0.image = .seperator
        }
        totalNumberLabel.do {
            $0.setText("총 6개", font: .caption02, color: .gray01)
            $0.textAlignment = .center
        }
        totalTimeIcon.do {
            $0.image = .clock
        }
        totalTimeLabel.do {
            $0.setText("58분", font: .caption02, color: .gray01)
            $0.textAlignment = .center
        }
        superSetIcon.do {
            $0.image = .toolTip
        }
        superSetLabel.do {
            $0.setText("슈퍼세트", font: .body01, color: .gray02)
        }
        superSetSwitch.do {
            $0.isOn = false
            $0.onTintColor = UIColor(named: "mainGreen")
            $0.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        }
    }
    
    private func setViewHierarchy() {
        self.addSubviews(totalNumberLabel, headerSeperator, totalTimeIcon, totalTimeLabel,
            superSetIcon, superSetLabel, superSetSwitch)
    }
    
    private func setAutoLayout() {
        totalNumberLabel.snp.makeConstraints() {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        headerSeperator.snp.makeConstraints() {
            $0.centerY.equalToSuperview().offset(-1)
            $0.leading.equalTo(totalNumberLabel.snp.trailing).offset(6)
        }
        totalTimeIcon.snp.makeConstraints() {
            $0.centerY.equalToSuperview().offset(-1)
            $0.leading.equalTo(headerSeperator.snp.trailing).offset(6)
            $0.size.equalTo(16)
        }
        totalTimeLabel.snp.makeConstraints() {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(totalTimeIcon.snp.trailing).offset(3)
        }
        superSetSwitch.snp.makeConstraints() {
            $0.centerY.equalToSuperview().offset(-1)
            $0.trailing.equalToSuperview().offset(-8)
        }
        superSetLabel.snp.makeConstraints() {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(superSetSwitch.snp.leading)
        }
        superSetIcon.snp.makeConstraints() {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(superSetLabel.snp.leading)
            $0.size.equalTo(20)
        }
    }
}
