//
//  ExerciseViewController.swift
//  PlanFit
//
//  Created by 김진웅 on 5/14/24.
//

import UIKit

protocol ExerciseNavigationDelegate: AnyObject {
    func moveToWorkoutList()
}

final class ExerciseViewController: UIViewController {
    
    // MARK: - UIComponent
    
    private let rootView = ExerciseRootView()
    
    // MARK: - Property
    
    private weak var delegate: ExerciseNavigationDelegate?
    
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
    
    // MARK: - Initializer
    
    init(delegate: ExerciseNavigationDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setTarget()
        fetchPlanOptions()
    }
}

// MARK: - Network

private extension ExerciseViewController {
    func fetchPlanOptions() {
        WorkoutService.shared.request(for: .getPlanOptions) { [weak self] result in
            switch result {
            case .success(let responseModel):
                guard let model = responseModel as? PlanOptionsResponseModel else { return }
                let data = model.data
                DispatchQueue.main.async {
                    self?.configureDropDowns(data.round, data.minute, data.condition)
                }
            case .requestErr:
                print(">>> 요청 오류 : \(#function)")
            case .decodedErr:
                print(">>> 디코딩 오류 : \(#function)")
            case .pathErr:
                print(">>> 경로 오류 : \(#function)")
            case .serverErr:
                print(">>> 서버 오류 : \(#function)")
            case .networkFail:
                print(">>> 네트워크 실패 : \(#function)")
            }
        }
    }
    
    func updatePlanOptions() {
        let requestModel = PlanOptionsRequestModel(minute: timeChoice.timeValue, condition: conditionChoice.value)
        
        WorkoutService.shared.request(for: .changePlanOptions(request: requestModel)) { result in
            switch result {
            case .success(let responseModel):
                guard let model = responseModel as? PlanOptionsResponseModel else { return }
                print(model)
            case .requestErr:
                print(">>> 요청 오류 : \(#function)")
            case .decodedErr:
                print(">>> 디코딩 오류 : \(#function)")
            case .pathErr:
                print(">>> 경로 오류 : \(#function)")
            case .serverErr:
                print(">>> 서버 오류 : \(#function)")
            case .networkFail:
                print(">>> 네트워크 실패 : \(#function)")
            }
        }
    }
}

// MARK: - WorkoutTimeSheetViewDelegate

extension ExerciseViewController: WorkoutTimeSheetViewDelegate {
    func dataBind(time userChoice: WorkoutTimeModel) {
        guard userChoice != timeChoice else { return }
        timeChoice = userChoice
        updatePlanOptions()
    }
}

// MARK: - BodyConditionSheetViewDelegate

extension ExerciseViewController: BodyConditionSheetViewDelegate {
    func dataBind(condition userChoice: BodyConditionModel) {
        guard userChoice != conditionChoice else { return }
        conditionChoice = userChoice
    }
}

// MARK: - Configure DropDown

private extension ExerciseViewController {
    func configureDropDowns(_ round: Int, _ minute: Int, _ condition: String) {
        let sessionButton = rootView.startExerciseBannerView.sessionsDropDownButton
        sessionButton.setTitle("\(round)회차", font: .subtitle02B, titleColor: .mainGreen)
        
        timeChoice = WorkoutTimeModel.convert(from: minute)
        
        configureTimeDropDown("\(minute)분")
        configureConditionDropDown(condition)
    }
    
    func configureTimeDropDown(_ title: String) {
        let timeDropDownButton = rootView.startExerciseBannerView.timeDropDownButton
        timeDropDownButton.setTitle(title, font: .subtitle02B, titleColor: .mainGreen)
    }
    
    func configureConditionDropDown(_ title: String) {
        let conditionsDropDownButton = rootView.startExerciseBannerView.conditionsDropDownButton
        conditionsDropDownButton.setTitle(title, font: .subtitle02B, titleColor: .mainGreen)
    }
}

// MARK: - UI Setting

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
    
    // MARK: - Action
    
    @objc
    func minutesDropDownButtonDidTap(_ sender: UIButton) {
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
    func conditionsDropDownButtonDidTap(_ sender: UIButton) {
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
    func startExerciseButtonDidTap(_ sender: UIButton) {
        delegate?.moveToWorkoutList()
    }
}
