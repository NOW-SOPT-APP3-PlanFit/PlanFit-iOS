//
//  WorkoutListViewController.swift
//  PlanFit
//
//  Created by 김진웅 on 5/14/24.
//

import UIKit

import SnapKit

final class WorkoutListViewController: UIViewController {
    
    // MARK: - WorkoutKind

    private enum WorkoutKind {
        case base(model: WorkoutListModel)
        case additional(model: WorkoutListExercises)
    }
    
    // MARK: - Property
    
    private let rootView = WorkoutListView()
    
    private var workoutDataList: [WorkoutKind] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.rootView.tableView.reloadData()
            }
        }
    }
    
    // MARK: - LifeCycle
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        register()
        setDelegate()
        setDraggable()
        setTarget()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetch()
    }
    
    // MARK: - TableView Setting
    
    private func register() {
        rootView.tableView.register(
            WorkoutListViewCell.self, forCellReuseIdentifier: WorkoutListViewCell.reuseIdentifier
        )
    }
    
    private func setDelegate() {
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
    }
    
    private func setDraggable() {
        self.rootView.tableView.dragInteractionEnabled = true
        self.rootView.tableView.dragDelegate = self
    }
}

// MARK: - Network

private extension WorkoutListViewController {
    
    func fetch() {
        WorkoutService.shared.request(for: .getWorkoutList) {
            [weak self] response in switch response {
            case .success(let responseModel):
                guard let model = responseModel as? WorkoutListResponseModel else { return }
                self?.configureList(workoutList: model.data)
            case .requestErr:
                print("요청 오류 입니다")
            case .decodedErr:
                print("디코딩 오류 입니다")
            case .pathErr:
                print("경로 오류 입니다")
            case .serverErr:
                print("서버 오류입니다")
            case .networkFail:
                print("네트워크 오류입니다")
            }
        }
    }
    
    func configureList(workoutList: WorkoutList) {
        var temp: [WorkoutKind] = [.base(model: .createDummy(for: .warmup))]
        
        for exercise in workoutList.exercises {
            temp.append(.additional(model: exercise))
        }
        
        temp.append(.base(model: .createDummy(for: .cooldown)))
        
        workoutDataList = temp
    }
}

// MARK: - UITableViewDelegate

extension WorkoutListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 || indexPath.row == (tableView.numberOfRows(inSection: indexPath.section) - 1) {
            if let cell = rootView.tableView.cellForRow(at: indexPath) as? WorkoutListViewCell {
                if cell.isExpanded {
                    return UITableView.automaticDimension
                }
            }
        }
        return 82
    }
}

// MARK: - UITableViewDataSource

extension WorkoutListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = rootView.tableView.dequeueReusableCell(
            withIdentifier: WorkoutListViewCell.reuseIdentifier,for: indexPath
        ) as? WorkoutListViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        
        let kind = workoutDataList[indexPath.row]
        
        switch kind {
        case .base(let model):
            cell.dataBind(model)
            cell.hideHamburgerButton()
        case .additional(let model):
            cell.dataBind(model)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row != 0 && indexPath.row != workoutDataList.count - 1
    }
    
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, 
                   toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if proposedDestinationIndexPath.row == 0 || proposedDestinationIndexPath.row == workoutDataList.count - 1 {
            return sourceIndexPath
        }
        return proposedDestinationIndexPath
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let moveCell = self.workoutDataList[sourceIndexPath.row]
        self.workoutDataList.remove(at: sourceIndexPath.row)
        self.workoutDataList.insert(moveCell, at: destinationIndexPath.row)
    }
}

// MARK: - UITableViewDragDelegate

extension WorkoutListViewController: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath)
    -> [UIDragItem] {
        if indexPath.row == 0 || indexPath.row == workoutDataList.count - 1 {
            return []
        } else {
            return [UIDragItem(itemProvider: NSItemProvider())]
        }
    }
}

// MARK: - Screen Navigation

private extension WorkoutListViewController {
    func setTarget() {
        let backButton = rootView.navigationBar.backButton
        backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        
        let startButton = rootView.startButton
        startButton.addTarget(self, action: #selector(startButtonDidTap), for: .touchUpInside)
    }
    
    @objc
    func backButtonDidTap(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func startButtonDidTap(_ sender: UIButton) {
        
        // TODO: 스트레칭 화면으로 네비게이션 Push
        
    }
}
