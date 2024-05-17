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
    
    private let header = UIView()
    
    private let headerSeperator = UIImageView()
    
    private let totalNumberLabel = UILabel()
    
    private let totalTimeIcon = UIImageView()
    
    private let totalTimeLabel = UILabel()
    
    private let superSetIcon = UIImageView()
    
    private let superSetLabel = UILabel()
    
    private let superSetSwitch = UISwitch()
    
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
            $0.tableHeaderView = header
            $0.tableFooterView = footer
        }
        header.do {
            $0.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 32)
        }
        headerSeperator.do {
            $0.image = .seperator
        }
        totalNumberLabel.do {
            $0.setText("총 6개", font: .caption02, color: .white)
        }
        totalTimeIcon.do {
            $0.image = .clock
        }
        totalTimeLabel.do {
            $0.setText("58분", font: .caption02, color: .white)
        }
        superSetIcon.do {
            $0.image = .toolTip
        }
        superSetLabel.do {
            $0.setText("슈퍼세트", font: .caption02, color: .white)
        }
        superSetSwitch.do {
            $0.isOn = false
            $0.onTintColor = UIColor(named: "mainGreen")
            $0.transform = CGAffineTransform(scaleX: 40/(superSetSwitch.bounds.size.width), y: 22/(superSetSwitch.bounds.size.height))
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
        header.addSubviews(
            totalNumberLabel,
            headerSeperator,
            totalTimeIcon,
            totalTimeLabel,
            superSetIcon,
            superSetLabel,
            superSetSwitch
        )
        footer.addSubviews(footerIcon, footerLabel)
    }
    
    private func setAutoLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        totalNumberLabel.snp.makeConstraints() {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        headerSeperator.snp.makeConstraints() {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(totalNumberLabel.snp.trailing).offset(6)
        }
        totalTimeIcon.snp.makeConstraints() {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(headerSeperator.snp.trailing).offset(6)
            $0.size.equalTo(16)
        }
        totalTimeLabel.snp.makeConstraints() {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(totalTimeIcon.snp.trailing).offset(3)
        }
        superSetSwitch.snp.makeConstraints() {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)
        }
        superSetLabel.snp.makeConstraints() {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(superSetSwitch.snp.leading).offset(-8)
        }
        superSetIcon.snp.makeConstraints() {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(superSetLabel.snp.leading)
            $0.size.equalTo(16)
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
