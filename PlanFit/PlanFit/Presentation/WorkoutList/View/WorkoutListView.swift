//
//  WorkoutListView.swift
//  PlanFit
//
//  Created by 김진웅 on 5/14/24.
//

import UIKit

import SnapKit

final class WorkoutListView: UIView {
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
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

private extension WorkoutListView {
    
    private func setUI() {
        tableView.do {
            $0.backgroundColor = UIColor(named: "gray08(BG)")
        }
    }
    private func setViewHierarchy() {
        self.addSubview(tableView)
    }
    
    private func setAutoLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
