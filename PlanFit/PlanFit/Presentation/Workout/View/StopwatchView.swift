//
//  StopwatchView.swift
//  PlanFit
//
//  Created by 왕정빈 on 5/16/24.
//

import UIKit

class StopwatchView: UIView {
    
    // MARK: - UI Component
    
    let currentTimeOnAirDot = UIImageView()
    
    let currentTimePlayImage = UIImageView()
    
    let currentTimeLabel = UILabel()
    
    // MARK: - Property

    var isRunning: Bool = false {
        didSet {
            currentTimeOnAirDot.image = isRunning ? .onairDot : .noOnairDot
            currentTimePlayImage.image = isRunning ? .pause : .play
            isRunning ? startTimer() : stopTimer()
        }
    }
    
    private var timer: Timer?
    
    static var workoutDuration = 0
    
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

private extension StopwatchView {
    func setUI() {
        self.do {
            $0.backgroundColor = .none
            $0.layer.borderColor = UIColor.mainGreen.cgColor
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 15
        }
        
        currentTimeOnAirDot.do {
            $0.image = UIImage(resource: .noOnairDot)
        }
        
        currentTimeLabel.do {
            $0.setText("00:00:00", font: .subtitle01, color: .gray01)
        }
        
        currentTimePlayImage.do {
            $0.image = UIImage(resource: .play)
        }
    }
    
    func setViewHierarchy() {
        addSubviews(currentTimeOnAirDot, currentTimeLabel, currentTimePlayImage)
    }
    
    func setAutoLayout() {
        self.snp.makeConstraints {
            $0.width.equalTo(133)
            $0.height.equalTo(30)
        }
        
        currentTimeOnAirDot.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(8)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(16)
        }
        
        currentTimeLabel.snp.makeConstraints {
            $0.leading.equalTo(currentTimeOnAirDot.snp.trailing).offset(1)
            $0.centerY.equalToSuperview()
        }
        
        currentTimePlayImage.snp.makeConstraints {
            $0.leading.equalTo(currentTimeLabel.snp.trailing).offset(1)
            $0.trailing.equalToSuperview().offset(-9)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(16)
        }
    }
}

// MARK: - Stopwatch

private extension StopwatchView {
    func startTimer() {
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(updateTimer),
            userInfo: nil,
            repeats: true
        )
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc
    func updateTimer() {
        StopwatchView.workoutDuration += 1
        updateUIForRemainingTime()
    }
    
    func updateUIForRemainingTime() {
        let formattedTime = formattedTime(for: StopwatchView.workoutDuration)
        currentTimeLabel.text = formattedTime
    }
    
    func formattedTime(for time: Int) -> String {
        let hours = time / 3600
        let minutes = time >= 3600 ? ((time - (hours * 3600)) / 60) : (time / 60)
        let seconds = time % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
