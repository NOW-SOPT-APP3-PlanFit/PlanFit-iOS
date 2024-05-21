//
//  ExerciseViewController.swift
//  PlanFit
//
//  Created by 김진웅 on 5/14/24.
//

import UIKit

final class ExerciseViewController: UIViewController {
    
    // MARK: - UIComponent
    
    private let rootView = ExerciseRootView()
    
    // MARK: - Property
    
    private var timeChoice = WorkoutTimeModel.normal {
        didSet {
            configureTimeDropDown("\(timeChoice.timeValue)분")
        }
    }
    
    private var conditionChoice = BodyConditionModel.better {
        didSet {
            configureConditionDropDown(conditionChoice.value)
        }
    }
    
    // MARK: - LifeCycle
    
    override func loadView() {
        super.loadView()
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setTarget()
    }
    
    // MARK: - Action
    
    @objc
    private func minutesDropDownButtonDidTap(_ sender: UIButton) {
        let viewController = WorkoutTimeSheetViewController(delegate: self, choice: timeChoice)
        viewController.modalPresentationStyle = .formSheet
        if let sheet = viewController.sheetPresentationController {
            sheet.detents = [.large(), .medium()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 30
        }
        present(viewController, animated: true)
    }
    
    @objc
    private func conditionsDropDownButtonDidTap(_ sender: UIButton) {
        let viewController = BodyConditionSheetViewController(delegate: self, choice: conditionChoice)
        viewController.modalPresentationStyle = .formSheet
        if let sheet = viewController.sheetPresentationController {
            sheet.detents = [.large(), .medium()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 30
        }
        present(viewController, animated: true)
    }
    
    @objc
    private func startExerciseButtonDidTap(_ sender: UIButton) {
        
        // TODO: 다음 화면 (운동 리스트) 화면으로 넘어가기
        
    }
}

// MARK: - WorkoutTimeSheetViewDelegate

extension ExerciseViewController: WorkoutTimeSheetViewDelegate {
    func dataBind(time userChoice: WorkoutTimeModel) {
        guard userChoice != timeChoice else { return }
        timeChoice = userChoice
    }
}

// MARK: - BodyConditionSheetViewDelegate

extension ExerciseViewController: BodyConditionSheetViewDelegate {
    func dataBind(condition userChoice: BodyConditionModel) {
        guard userChoice != conditionChoice else { return }
        conditionChoice = userChoice
    }
}

// MARK: - ConfigureDropDown

private extension ExerciseViewController {
    func configureTimeDropDown(_ title: String) {
        let timeDropDownButton = rootView.startExerciseBannerView.timeDropDownButton
        timeDropDownButton.setTitle(title, font: .subtitle02B, titleColor: .mainGreen)
    }
    
    func configureConditionDropDown(_ title: String) {
        let conditionsDropDownButton = rootView.startExerciseBannerView.conditionsDropDownButton
        conditionsDropDownButton.setTitle(title, font: .subtitle02B, titleColor: .mainGreen)
    }
}

// MARK: - UISetting

private extension ExerciseViewController {
    func setNavigationBar() {
        let categoryButton = UIButton().then {
            var configuration = UIButton.Configuration.plain()
            configuration.imagePlacement = .trailing
            configuration.imagePadding = 5
            configuration.baseForegroundColor = .gray01
            $0.configuration = configuration
            $0.setTitle("헬스", font: .head02, titleColor: .gray01)
            $0.setImage(.arrowBottom, for: .normal)
        }
        
        let premiumButton = UIButton().then {
            $0.setBackgroundImage(.btnPremium, for: .normal)
            $0.frame = CGRect(x: 0, y: 0, width: Screen.width(90), height: Screen.height(27))
        }
        
        let settingsButton = UIButton().then {
            $0.setBackgroundImage(.settings, for: .normal)
            $0.frame = CGRect(x: 0, y: 0, width: Screen.width(20), height: Screen.height(20))
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: categoryButton)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: settingsButton),
            UIBarButtonItem(customView: premiumButton)
        ]
        
        let navigationBarSeparator = UIView(frame: CGRect(
            x: 0,
            y: Screen.height(54),
            width: navigationController!.navigationBar.frame.width,
            height: 0.2
        ))
        navigationBarSeparator.backgroundColor = .gray
        navigationBarSeparator.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        navigationController?.navigationBar.addSubview(navigationBarSeparator)
    }
    
    
    func setTarget() {
        let timeDropDownButton = rootView.startExerciseBannerView.timeDropDownButton
        let conditionsDropDownButton = rootView.startExerciseBannerView.conditionsDropDownButton
        let startExerciseButton = rootView.exerciseInfoBannerView.startExerciseButton
        
        timeDropDownButton.addTarget(
            self,
            action: #selector(minutesDropDownButtonDidTap),
            for: .touchUpInside
        )
        
        conditionsDropDownButton.addTarget(
            self,
            action: #selector(conditionsDropDownButtonDidTap),
            for: .touchUpInside
        )
        
        startExerciseButton.addTarget(
            self,
            action: #selector(startExerciseButtonDidTap),
            for: .touchUpInside
        )
    }
}
