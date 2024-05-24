//
//  InfoItemView.swift
//  PlanFit
//
//  Created by 김진웅 on 5/17/24.
//

import UIKit

import SnapKit

final class InfoItemView: UIView {
    
    // MARK: - UIComponent
    
    private let imageView = UIImageView()
    
    private let explanationLabel = UILabel()
    
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
    
    func configure(image: UIImage, text: String) {
        imageView.image = image
        explanationLabel.setText(text, font: .body01, color: .gray02)
    }
}

// MARK: - UISetting

private extension InfoItemView {
    func setUI() {
        imageView.do {
            $0.image = UIImage(systemName: "flame")
        }
        
        explanationLabel.do {
            $0.setText("", font: .body01, color: .gray02)
            $0.textAlignment = .center
        }
    }
    
    func setViewHierarchy() {
        addSubviews(imageView, explanationLabel)
    }
    
    func setAutoLayout() {
        imageView.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
            $0.height.equalTo(Screen.height(40))
            $0.width.equalTo(imageView.snp.height)
        }
        
        explanationLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
