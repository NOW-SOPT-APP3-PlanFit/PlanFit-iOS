//
//  WarmUpView.swift
//  PlanFit
//
//  Created by 김진웅 on 5/14/24.
//

import UIKit

import SnapKit

final class WarmUpView: UIView {
    
    // MARK: - UIComponent
    
    private let titleLabel = UILabel()
    
    private let countLabel = UILabel()
    
    private let titleStackView = UIStackView(axis: .horizontal)
    
    private let currentWarmUpLabel = UILabel()
    
    private let subtitleLabel = UILabel()
    
    private let nextWarmUpLabel = UILabel()
    
    private let subtitleStackView = UIStackView(axis: .vertical)
    
    private let floatingActionButton = UIButton()
    
    private let warmUpImageView = UIImageView()
    
    let progressView = UIProgressView(progressViewStyle: .bar)
    
    let timeLabel = UILabel()
    
    let resetButton = UIButton()
    
    let pauseButton = PauseButton()
    
    let nextButton = UIButton()
    
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
}

// MARK: - UI Setting

private extension WarmUpView {
    func setUI() {
        backgroundColor = .gray08BG
        
        titleLabel.do {
            $0.setText("웜업 스트레칭", font: .body01, color: .mainGreen)
        }
        
        countLabel.do {
            $0.setText("1/6", font: .caption03, color: .gray02)
            $0.backgroundColor = .gray07
        }
        
        titleStackView.do {
            $0.spacing = 4
        }
        
        currentWarmUpLabel.do {
            $0.setText("사이클", font: .head04, color: .gray01)
        }
        
        subtitleLabel.do {
            $0.setText("다음 웜업 스트레칭", font: .caption02, color: .gray02)
        }
        
        nextWarmUpLabel.do {
            $0.setText("옆구리/허리 스트레칭", font: .body01B, color: .gray01)
        }
        
        subtitleStackView.do {
            $0.spacing = 4
            $0.alignment = .leading
        }
        
        floatingActionButton.do {
            var configuration = UIButton.Configuration.plain()
            configuration.image = UIImage(resource: .fab).withRenderingMode(.alwaysOriginal)
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: -10)
            $0.configuration = configuration
        }
        
        warmUpImageView.do {
            let image = UIImage(resource: .cycle).withRenderingMode(.alwaysOriginal)
            $0.image = image
            $0.contentMode = .scaleAspectFill
        }
        
        progressView.do {
            $0.progress = 0.0
            $0.progressTintColor = .mainGreen
            $0.backgroundColor = .gray07
            $0.layer.cornerRadius = 8
        }
        
        timeLabel.do {
            $0.setText("00:00", font: .head01, color: .gray01)
            $0.textAlignment = .center
        }
        
        resetButton.do {
            $0.setImage(.reverse, for: .normal)
            $0.tintColor = .gray01
            $0.backgroundColor = .gray05
            $0.layer.cornerRadius = 16
        }
        
        nextButton.do {
            $0.setImage(.playnext, for: .normal)
            $0.tintColor = .gray01
            $0.backgroundColor = .gray05
            $0.layer.cornerRadius = 16
        }
    }
    
    func setViewHierarchy() {
        titleStackView.addArrangedSubviews(titleLabel, countLabel)
        subtitleStackView.addArrangedSubviews(subtitleLabel, nextWarmUpLabel)
        addSubviews(
            titleStackView, currentWarmUpLabel, subtitleStackView, floatingActionButton, warmUpImageView,
            progressView, timeLabel, resetButton, pauseButton, nextButton
        )
        bringSubviewToFront(floatingActionButton)
        bringSubviewToFront(timeLabel)
    }
    
    func setAutoLayout() {
        let safeArea = safeAreaLayoutGuide
        
        titleStackView.snp.makeConstraints {
            $0.top.equalTo(safeArea).offset(12)
            $0.leading.equalToSuperview().offset(17)
        }
        
        currentWarmUpLabel.snp.makeConstraints {
            $0.top.equalTo(titleStackView.snp.bottom).offset(10)
            $0.leading.equalTo(titleStackView)
        }
        
        subtitleStackView.snp.makeConstraints {
            $0.top.equalTo(safeArea).offset(34)
            $0.trailing.equalToSuperview().offset(-17)
        }
        
        floatingActionButton.snp.makeConstraints {
            $0.top.equalTo(safeArea).offset(100)
            $0.trailing.equalToSuperview()
        }
        
        warmUpImageView.snp.makeConstraints {
            $0.top.equalTo(subtitleStackView.snp.bottom).offset(72)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(Screen.height(312))
        }
        
        resetButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(17)
            $0.bottom.equalTo(safeArea).offset(-23)
            $0.width.equalTo(Screen.width(100))
            $0.height.equalTo(Screen.height(56))
        }
        
        pauseButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(resetButton)
            $0.width.equalTo(Screen.width(127))
            $0.height.equalTo(resetButton)
        }
        
        nextButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-17)
            $0.bottom.equalTo(resetButton)
            $0.width.height.equalTo(resetButton)
        }
        
        progressView.snp.makeConstraints {
            $0.bottom.equalTo(pauseButton.snp.top).offset(-74)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(Screen.height(50))
        }
        
        timeLabel.snp.makeConstraints {
            $0.centerX.equalTo(progressView)
            $0.centerY.equalTo(progressView).offset(2)
        }
    }
}
