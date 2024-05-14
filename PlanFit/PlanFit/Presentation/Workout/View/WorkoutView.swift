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
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    private let currentTimeOnAirDot = UIImageView()
    
    private let currentTimeLabel = UILabel()
    
    private let currentTimePlayImage = UIImageView()
    
    private lazy var breakTimerButton = UIButton()
    
    private lazy var completeSetButton = UIButton()
    
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
        
        collectionView.do {
            $0.backgroundColor = .gray08BG
            $0.register(WorkoutImageCell.self, forCellWithReuseIdentifier: WorkoutImageCell.reuseIdentifier)
        }
        
        breakTimerButton.do {
            $0.setTitle("휴식 타이머", font: .subtitle01, titleColor: .mainGreen)
            $0.backgroundColor = .gray05
            $0.layer.cornerRadius = 15
        }
        
        completeSetButton.do {
            $0.setTitle("1 세트 완료", font: .subtitle01, titleColor: .gray10)
            $0.backgroundColor = .mainGreen
            $0.layer.cornerRadius = 15
        }
        
    }
    
    func setViewHierarchy() {
        currentTimeView.addSubviews(currentTimeOnAirDot, currentTimeLabel, currentTimePlayImage)
        
        addSubviews(collectionView, breakTimerButton, completeSetButton)
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
        
        collectionView.snp.makeConstraints { $0.edges.equalTo(safeAreaLayoutGuide) }
        
        breakTimerButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(17)
            $0.bottom.equalTo(safeAreaLayoutGuide)
            $0.width.equalTo(123)
            $0.height.equalTo(56)
        }
        
        completeSetButton.snp.makeConstraints {
            $0.leading.equalTo(breakTimerButton.snp.trailing).offset(6)
            $0.trailing.equalToSuperview().offset(-18)
            $0.bottom.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(56)
        }
    }
}
