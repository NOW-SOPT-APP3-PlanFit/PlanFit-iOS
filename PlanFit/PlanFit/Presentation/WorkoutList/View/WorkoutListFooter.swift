//
//  WorkoutListFooter.swift
//  PlanFit
//
//  Created by 예삐 on 5/22/24.
//

import UIKit

import SnapKit

final class WorkoutListFooter: UIView {
    
    // MARK: - UIComponent
    
    private let footerIcon = UIImageView()
    
    private let footerLabel = UILabel()
    
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

private extension WorkoutListFooter {
    
    func setUI() {
        self.do {
            $0.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 180)
        }
        footerIcon.do {
            //$0.image = .plus
            $0.image = .clock
        }
        footerLabel.do {
            $0.setText("운동 추가하기", font: .subtitle02B, color: .gray02)
        }
    }
    
    func setViewHierarchy() {
        self.addSubviews(footerIcon, footerLabel)
    }
    
    func setAutoLayout() {
        footerIcon.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(20)
        }
        footerLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(48)
        }
    }
}
