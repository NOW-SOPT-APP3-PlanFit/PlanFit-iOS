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
    
    private let navigationBar = WorkoutListNavigation()
    
    private let header = WorkoutListHeader()
    
    private let footer = WorkoutListFooter()
    
    private let buttonBackGradiant = UIImageView()
    
    private let startButton = UIButton()

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
            $0.tableHeaderView = header
            $0.tableFooterView = footer
        }
        buttonBackGradiant.do {
            $0.image = .buttonBackGradiant
        }
        startButton.do {
            $0.backgroundColor = .mainGreen
            $0.setTitle("시작하기", font: .subtitle01, titleColor: .gray10)
            $0.setLayer(borderWidth: 0, borderColor: .mainGreen, cornerRadius: 15.0)
        }
    }
    
    private func setViewHierarchy() {
        self.addSubviews(navigationBar, tableView, buttonBackGradiant, startButton)
    }
    
    private func setAutoLayout() {
        navigationBar.snp.makeConstraints() {
            $0.top.leading.trailing.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(48)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(startButton.snp.top).offset(-20)
        }
        buttonBackGradiant.snp.makeConstraints() {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(160)
        }
        startButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-20)
            $0.height.equalTo(56)
        }
    }
}
