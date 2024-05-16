//
//  WorkoutListViewController.swift
//  PlanFit
//
//  Created by 김진웅 on 5/14/24.
//

import UIKit

import SnapKit

final class WorkoutListViewController: UIViewController {
    
    private let rootView = WorkoutListView()
    
    private let workoutList = WorkoutListModel.dummy()
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        register()
        setDelegate()
    }
    
    private func register() {
        rootView.tableView.register(
            WorkoutListViewCell.self, forCellReuseIdentifier: WorkoutListViewCell.identifier
        )
    }
    
    private func setDelegate() {
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
    }
}

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
        return cell
    }
}
