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
    
    private let footer = UIView()
    
    private let footerIcon = UIImageView()
    
    private let footerLabel = UILabel()
    
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
            $0.tableFooterView = footer
        }
        footer.do {
            $0.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 44)
        }
        footerIcon.do {
            $0.image = .plus
        }
        footerLabel.do {
            $0.setText("운동 추가하기", font: .subtitle02B, color: .white)

        }
    }
    
    private func setViewHierarchy() {
        self.addSubview(tableView)
        footer.addSubviews(footerIcon, footerLabel)
    }
    
    private func setAutoLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        footerIcon.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        footerLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(48)
        }
    }
}
