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
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    lazy var completeSetButton = UIButton()
    
    private lazy var breakTimerButton = UIButton()
    
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
        
        collectionView.do {
            $0.showsVerticalScrollIndicator = false
            $0.backgroundColor = .gray08BG
            $0.register(WorkoutImageCell.self, forCellWithReuseIdentifier: WorkoutImageCell.reuseIdentifier)
            $0.register(WorkoutImageHeader.self,
                        forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                        withReuseIdentifier: WorkoutImageHeader.reuseIdentifier)
            $0.register(WorkoutImageFooter.self,
                        forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                        withReuseIdentifier: WorkoutImageFooter.reuseIdentifier)
            $0.register(WorkoutSetCell.self, forCellWithReuseIdentifier: WorkoutSetCell.reuseIdentifier)
            $0.register(WorkoutSetFooter.self, 
                        forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                        withReuseIdentifier: WorkoutSetFooter.reuseIdentifier)
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
        addSubviews(collectionView, breakTimerButton, completeSetButton)
    }
    
    func setAutoLayout() {
        collectionView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalTo(breakTimerButton.snp.top)
        }
        
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
