//
//  WorkoutListViewController.swift
//  PlanFit
//
//  Created by 김진웅 on 5/14/24.
//

import UIKit

import SnapKit

final class WorkoutListViewController: UIViewController {
    
    // MARK: - Property
    
    private let rootView = WorkoutListView()
    
    private var workoutList = WorkoutListModel.dummy()
    
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
    
    // MARK: - TableView Setting
    
    private func register() {
        rootView.tableView.register(
            WorkoutListViewCell.self, forCellReuseIdentifier: WorkoutListViewCell.identifier
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
        return workoutList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = rootView.tableView.dequeueReusableCell(
            withIdentifier: WorkoutListViewCell.identifier,for: indexPath
        ) as? WorkoutListViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.dataBind(workoutList[indexPath.row])
        
        if indexPath.row == 0 || indexPath.row == workoutList.count - 1 {
            cell.hideHamburgerButton()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row != 0 && indexPath.row != workoutList.count - 1
    }
    
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, 
                   toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if proposedDestinationIndexPath.row == 0 || proposedDestinationIndexPath.row == workoutList.count - 1 {
            return sourceIndexPath
        }
        return proposedDestinationIndexPath
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let moveCell = self.workoutList[sourceIndexPath.row]
        self.workoutList.remove(at: sourceIndexPath.row)
        self.workoutList.insert(moveCell, at: destinationIndexPath.row)
    }
}

// MARK: - UITableViewDragDelegate

extension WorkoutListViewController: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath)
    -> [UIDragItem] {
        if indexPath.row == 0 || indexPath.row == workoutList.count - 1 {
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
