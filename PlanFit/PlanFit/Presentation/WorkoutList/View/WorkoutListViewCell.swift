//
//  WorkoutListViewCell.swift
//  PlanFit
//
//  Created by 예삐 on 5/15/24.
//

import UIKit

import SnapKit

final class WorkoutListViewCell: UITableViewCell {
    
    static let identifier = "WorkoutListViewCell"
    
    var isExpanded = false
    
    private let hamburgerIcon = UIImageView()
    
    private let workoutImage = UIImageView()
    
    private let nameLabel = UILabel()
    
    private let captionLabel = UILabel()
    
    private let additionalInfoLabel = UILabel()
    
    private let arrowButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor(named: "gray08(BG)")
        
        setUI()
        setViewHierarchy()
        setAutoLayout()
        
        setTarget()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTarget() {
        arrowButton.addTarget(self, action: #selector(arrowButtonDidTap), for: .touchUpInside)
    }
    
    @objc
    private func arrowButtonDidTap(){
        guard let currentImage = arrowButton.currentImage else { return }
        
        if currentImage == UIImage.arrowDown {
            arrowButton.setImage(UIImage.arrowTop, for: .normal)
            isExpanded = true
            additionalInfoLabel.isHidden = false
            arrowButton.setImage(UIImage.arrowTop, for: .normal)
        } else if currentImage == UIImage.arrowTop {
            arrowButton.setImage(UIImage.arrowDown, for: .normal)
            isExpanded = false
            additionalInfoLabel.isHidden = true
        }
        invalidateIntrinsicContentSize()
    }
}

private extension WorkoutListViewCell {
    func setUI() {
        hamburgerIcon.do {
            $0.image = .hamburger
        }
        nameLabel.do {
            $0.textColor = .white
            $0.textAlignment = .left
            $0.font = UIFont.neoFont(for: .subtitle02B)
        }
        captionLabel.do {
            $0.textColor = .white
            $0.textAlignment = .left
            $0.font = UIFont.neoFont(for: .caption02)
        }
        additionalInfoLabel.do {
            $0.textColor = .white
            $0.textAlignment = .left
            $0.numberOfLines = 6
            $0.font = UIFont.neoFont(for: .caption02)
        }
    }
    
    func setViewHierarchy() {
        contentView.addSubviews(hamburgerIcon, workoutImage, nameLabel, captionLabel, additionalInfoLabel, arrowButton)
    }
    
    func setAutoLayout() {
        hamburgerIcon.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalToSuperview().offset(11)
            $0.size.equalTo(24)
        }
        workoutImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(11)
            $0.leading.equalToSuperview().offset(39)
            $0.width.equalTo(70)
            $0.height.equalTo(60)
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(124)
        }
        captionLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(124)
        }
        additionalInfoLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(88)
            $0.bottom.lessThanOrEqualToSuperview().offset(-8)
            $0.leading.equalToSuperview().offset(124)
        }
        arrowButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-14)
            $0.size.equalTo(24)
        }
    }
}

extension WorkoutListViewCell {
    func dataBind (_ data: WorkoutListModel) {
        nameLabel.text = data.nameLabel
        workoutImage.image = data.workoutImage
        captionLabel.text = data.captionLabel
        arrowButton.setImage(data.arrowButton, for: .normal)
        additionalInfoLabel.text = data.additionalInfoLabel
    }
}
