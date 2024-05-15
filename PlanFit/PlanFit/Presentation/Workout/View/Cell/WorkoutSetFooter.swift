//
//  WorkoutSetFooter.swift
//  PlanFit
//
//  Created by 왕정빈 on 5/16/24.
//

import UIKit

import SnapKit

class WorkoutSetFooter: UICollectionReusableView, ReuseIdentifiable {
    
    // MARK: - UI Component
    
    let addSetStackView = UIStackView()
    
    private let plusImage = UIImageView()
    
    private let addSetLabel = UILabel()
    
    private let setModifyView = UIView()
    
    private let pencilImage = UIImageView()
    
    private let setModifyLabel = UILabel()
        
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

// MARK: - UI Setting

private extension WorkoutSetFooter {
    func setUI() {
        plusImage.do { $0.image = UIImage(resource: .plus) }
        
        addSetLabel.do { $0.setText("세트 추가", font: .body01B, color: .gray02)}
        
        addSetStackView.do {
            $0.axis = .horizontal
            $0.spacing = 4
        }
        
        pencilImage.do { $0.image = UIImage(resource: .pencil) }
        
        setModifyLabel.do { $0.setText("세트 수정", font: .subtitle02B, color: .gray02)}
        
        setModifyView.do {
            $0.backgroundColor = .gray07
            $0.layer.cornerRadius = 10
        }
    }
    
    func setViewHierarchy() {
        addSetStackView.addArrangedSubviews(plusImage, addSetLabel)
        
        setModifyView.addSubviews(pencilImage, setModifyLabel)
        
        addSubviews(addSetStackView, setModifyView)
    }
    
    func setAutoLayout() {
        plusImage.snp.makeConstraints { $0.width.height.equalTo(16) }
        
        addSetStackView.snp.makeConstraints { $0.top.leading.equalToSuperview().offset(16) }
        
        pencilImage.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(131)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(16)
        }
        
        setModifyLabel.snp.makeConstraints {
            $0.leading.equalTo(pencilImage.snp.trailing).offset(4)
            $0.trailing.equalToSuperview().offset(-131)
            $0.centerY.equalToSuperview()
        }
        
        setModifyView.snp.makeConstraints { 
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(addSetStackView.snp.bottom).offset(22)
            $0.height.equalTo(44)
        }
    }
}

