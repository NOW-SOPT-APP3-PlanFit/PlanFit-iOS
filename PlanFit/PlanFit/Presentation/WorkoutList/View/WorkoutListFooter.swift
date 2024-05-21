//
//  WorkoutListFooter.swift
//  PlanFit
//
//  Created by 예삐 on 5/22/24.
//

import UIKit

import SnapKit

final class WorkoutListFooter: UIView {
    
    private let footerIcon = UIImageView()
    
    private let footerLabel = UILabel()
    
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

private extension WorkoutListFooter {
    
    private func setUI() {
        self.do {
            $0.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 48)
        }
        footerIcon.do {
            $0.image = .plus
        }
        footerLabel.do {
            $0.setText("운동 추가하기", font: .subtitle02B, color: .gray02)
        }
    }
    
    private func setViewHierarchy() {
        self.addSubviews(footerIcon, footerLabel)
    }
    
    private func setAutoLayout() {
        footerIcon.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        footerLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(48)
        }
    }
}
