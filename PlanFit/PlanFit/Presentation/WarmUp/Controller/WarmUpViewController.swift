//
//  WarmUpViewController.swift
//  PlanFit
//
//  Created by 김진웅 on 5/14/24.
//

import UIKit

final class WarmUpViewController: UIViewController {
    
    // MARK: - UIComponent
    
    private let rootView = WarmUpView()
    
    private let stopwatchView = StopwatchView()
    
    // MARK: - Property
    
    private var timer: Timer?
    
    private var remainingTime = 0
    
    private let duration = 300
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStopwatch()
        setNavigationBar()
        setProgressView()
        setTarget()
        
        startTimer(for: duration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        stopTimer()
    }
}

// MARK: - Timer

private extension WarmUpViewController {
    func startTimer(for time: Int) {
        remainingTime = time
        
        rootView.pauseButton.isPlaying = true
        updateUIForRemainingTime()
        
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(updateTimer),
            userInfo: nil,
            repeats: true
        )
    }
    
    func stopTimer() {
        rootView.pauseButton.isPlaying = false
        
        timer?.invalidate()
        timer = nil
    }
    
    @objc 
    func updateTimer() {
        if remainingTime > 0 {
            remainingTime -= 1
            updateUIForRemainingTime()
        }
    }
    
    func updateUIForRemainingTime() {
        let formattedTime = formattedTime(for: remainingTime)
        rootView.timeLabel.setText(formattedTime, font: .head01, color: .gray01)
        rootView.progressView.setProgress(Float(duration - remainingTime) / Float(duration), animated: true)
    }
    
    func formattedTime(for time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

// MARK: - UI Setting

private extension WarmUpViewController {
    func setStopwatch() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(stopwatchViewDidTap))
        stopwatchView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func setNavigationBar() {
        let backButton = UIBarButtonItem(
            image: .arrowLeft.withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(backButtonDidTap)
        )
        
        let skipButton = UIButton().then {
            var configuration = UIButton.Configuration.plain()
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            configuration.baseForegroundColor = .mainGreen
            $0.configuration = configuration
            $0.setTitle("웜업생략", font: .body01, titleColor: .mainGreen)
            $0.backgroundColor = .gray06
            $0.layer.cornerRadius = 6
            $0.addTarget(self, action: #selector(skipButtonDidTap), for: .touchUpInside)
        }
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.titleView = stopwatchView
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: skipButton)
    }
    
    func setProgressView() {
        rootView.progressView.setProgress(0, animated: false)
        rootView.timeLabel.setText(formattedTime(for: duration), font: .head01, color: .gray01)
    }
    
    func setTarget() {
        let resetButton = rootView.resetButton
        let pauseButton = rootView.pauseButton
        let nextButton = rootView.nextButton
        
        resetButton.addTarget(self, action: #selector(resetButtonDidTap), for: .touchUpInside)
        pauseButton.addTarget(self, action: #selector(pauseButtonDidTap), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
    }
    
    // MARK: - Action
    
    @objc
    func stopwatchViewDidTap() {
        stopwatchView.isRunning.toggle()
    }
    
    @objc
    func backButtonDidTap(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func skipButtonDidTap(_ sender: UIButton) {
        let viewController = WorkoutViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc 
    func resetButtonDidTap(_ sender: UIButton) {
        stopTimer()
        startTimer(for: duration)
    }
    
    @objc 
    func pauseButtonDidTap(_ sender: PauseButton) {
        sender.isPlaying.toggle()
        sender.isPlaying ? startTimer(for: remainingTime == 0 ? duration : remainingTime) : stopTimer()
    }
    
    @objc 
    func nextButtonDidTap(_ sender: UIButton) {
        stopTimer()
        remainingTime = 0
        rootView.timeLabel.setText("00:00", font: .head01, color: .gray01)
        rootView.progressView.setProgress(1, animated: false)
        rootView.pauseButton.isPlaying = false
    }
}
