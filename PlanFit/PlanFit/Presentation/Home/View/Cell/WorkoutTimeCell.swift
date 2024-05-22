//
//  WorkoutTimeCell.swift
//  PlanFit
//
//  Created by 김진웅 on 5/21/24.
//

import UIKit

import SnapKit

final class WorkoutTimeCell: UICollectionViewCell, ReuseIdentifiable {
    
    // MARK: - UIComponent
    
    private let titleLabel = UILabel()
    
    private let descriptionLabel = UILabel()
    
    // MARK: - Property

    override var isSelected: Bool {
        didSet {
            contentView.layer.borderWidth = isSelected ? 1 : 0
        }
    }
    
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
    
    func dataBind(title: String, description: String, isCurrentChoice: Bool) {
        titleLabel.setText(title, font: .subtitle01, color: .gray01)
        descriptionLabel.setText(description, font: .body01, color: .gray01)
        contentView.layer.borderWidth = isCurrentChoice ? 1 : 0
    }
}

// MARK: - UISetting

private extension WorkoutTimeCell {
    func setUI() {
        contentView.do {
            $0.backgroundColor = .gray05
            $0.layer.cornerRadius = 10
            $0.layer.borderColor = UIColor.mainGreen.cgColor
        }
        
        titleLabel.do {
            $0.setText("", font: .subtitle01, color: .gray01)
        }
        
        descriptionLabel.do {
            $0.setText("", font: .body01, color: .gray01)
        }
    }
    
    func setViewHierarchy() {
        contentView.addSubviews(titleLabel, descriptionLabel)
    }
    
    func setAutoLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(23)
            $0.leading.equalToSuperview().offset(17)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(19)
            $0.centerY.equalTo(titleLabel)
        }
    }
}
