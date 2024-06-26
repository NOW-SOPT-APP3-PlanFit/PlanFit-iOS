//
//  WorkoutImageHeader.swift
//  PlanFit
//
//  Created by 왕정빈 on 5/15/24.
//

import UIKit

import SnapKit

protocol HeartButtonDidTapDelegate: AnyObject {
    func updateHeart(_ heartButton: UIButton, isFilled: Bool)
}

final class WorkoutImageHeader: UICollectionReusableView, ReuseIdentifiable {
    
    // MARK: - UI Component
    
    private let workoutOrderLabel = UILabel()
    
    private let workoutOrderView = UIView()
    
    private let currentWorkout = UILabel()
    
    private let heartButton = UIButton()
    
    private let nextWorkoutLabel = UILabel()
    
    private let nextWorkoutName = UILabel()
    
    private let currentWorkoutStackView = UIStackView()
    
    private let nextWorkoutStackView = UIStackView()
    
    // MARK: - Property
    
    weak var delegate: HeartButtonDidTapDelegate?
    
    private var heartIsFilled = false
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setViewHierarchy()
        setAutoLayout()
        setTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI Setting

private extension WorkoutImageHeader {
    func setUI() {
        workoutOrderLabel.do { $0.setText("1 / 6", font: .caption03, color: .gray02) }
        
        workoutOrderView.do {
            $0.backgroundColor = .gray07
            $0.layer.cornerRadius = 5
        }
        
        currentWorkout.do { $0.setText("랫 풀다운", font: .head04, color: .gray01) }
        
        heartButton.do { $0.setImage(UIImage(resource: .heartEmpty), for: .normal) }
        
        nextWorkoutLabel.do { $0.setText("다음 운동", font: .caption02, color: .gray02) }
        
        nextWorkoutName.do { $0.setText("체스트 프레스 머신", font: .body01B, color: .gray01) }
        
        currentWorkoutStackView.do {
            $0.axis = .vertical
            $0.alignment = .leading
            $0.spacing = 10
        }
        
        nextWorkoutStackView.do {
            $0.axis = .vertical
            $0.alignment = .leading
            $0.spacing = 4
        }
    }
    
    func setViewHierarchy() {
        workoutOrderView.addSubview(workoutOrderLabel)
        
        currentWorkoutStackView.addArrangedSubviews(workoutOrderView, currentWorkout)
        
        nextWorkoutStackView.addArrangedSubviews(nextWorkoutLabel, nextWorkoutName)
        
        addSubviews(currentWorkoutStackView, heartButton, nextWorkoutStackView)
    }
    
    func setAutoLayout() {
        workoutOrderLabel.snp.makeConstraints { $0.center.equalToSuperview() }
        
        workoutOrderView.snp.makeConstraints {
            $0.width.equalTo(32)
            $0.height.equalTo(21)
        }
        
        currentWorkoutStackView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
        }
        
        heartButton.snp.makeConstraints {
            $0.leading.equalTo(currentWorkout.snp.trailing).offset(4)
            $0.bottom.equalToSuperview().offset(-2)
            $0.width.height.equalTo(24)
        }
        
        nextWorkoutStackView.snp.makeConstraints { $0.trailing.bottom.equalToSuperview() }
    }
    
    // MARK: - Action
    
    func setTarget() {
        heartButton.addTarget(self, action: #selector(heartButtonDidTap), for: .touchUpInside)
    }
    
    @objc
    func heartButtonDidTap(_ sender: UIButton) {
        delegate?.updateHeart(sender, isFilled: heartIsFilled)
        
        heartIsFilled.toggle()
        heartButton.setImage(heartIsFilled ? .heartFill : .heartEmpty, for: .normal)
    }
}
