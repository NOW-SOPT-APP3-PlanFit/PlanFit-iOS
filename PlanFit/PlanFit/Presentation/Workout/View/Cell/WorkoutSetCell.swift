//
//  WorkoutSetCell.swift
//  PlanFit
//
//  Created by 왕정빈 on 5/15/24.
//

import UIKit

import SnapKit

class WorkoutSetCell: UICollectionViewCell, ReuseIdentifiable {
    
    // MARK: - UI Component
    
    private let setCount = UILabel()
    
    private let weight = UILabel()
    
    private let kgLabel = UILabel()
    
    private let repsNum = UILabel()
    
    private let repsLabel = UILabel()
    
    private let slash = UIImageView()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setViewHierarchy()
        setAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension WorkoutSetCell {
    func setUI() {
        layer.cornerRadius = 10
        
        setCount.do { $0.setText("", font: .body01B, color: .gray04) }
        
        weight.do { 
            $0.setText("", font: .subtitle01, color: .gray04)
            $0.textAlignment = .right
        }
        
        kgLabel.do { $0.setText("kg", font: .subtitle02, color: .gray04) }
        
        repsNum.do {
            $0.setText("", font: .subtitle01, color: .gray04)
            $0.textAlignment = .right
        }
        
        repsLabel.do { $0.setText("회", font: .subtitle02, color: .gray04) }
        
        slash.do { $0.image = UIImage(resource: .slash) }
    }
    
    func setViewHierarchy() {
        addSubviews(setCount, weight, kgLabel, repsNum, repsLabel, slash)
    }
    
    func setAutoLayout() {
        setCount.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(33.5)
            $0.centerY.equalToSuperview()
        }
        
        weight.snp.makeConstraints {
            $0.leading.equalTo(setCount.snp.trailing).offset(48)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(35)
        }
        
        kgLabel.snp.makeConstraints {
            $0.leading.equalTo(weight.snp.trailing).offset(0.5)
            $0.bottom.equalTo(weight).offset(1.5)
            $0.width.equalTo(16)
        }
        
        slash.snp.makeConstraints {
            $0.leading.equalTo(kgLabel.snp.trailing).offset(35)
            $0.centerY.equalToSuperview().offset(1)
            $0.width.height.equalTo(16)
        }
        
        repsNum.snp.makeConstraints {
            $0.leading.equalTo(slash.snp.trailing).offset(17)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(35)
        }
        
        repsLabel.snp.makeConstraints {
            $0.leading.equalTo(repsNum.snp.trailing).offset(0.5)
            $0.trailing.equalToSuperview().offset(-33)
            $0.bottom.equalTo(repsNum).offset(1)
            $0.width.equalTo(14)
        }
    }
}

// MARK: - Data Bind

extension WorkoutSetCell {
    func dataBind(setData data: SetVolume, setNum: Int) {
        setCount.text = "\(setNum + 1)세트"
        weight.text = String(data.weight)
        repsNum.text = String(data.repsNum)
    }
}

// MARK: - Current, Completed Set setting

extension WorkoutSetCell {
    func currentSetAttributes(setData data: SetVolume) {
        guard data.currentSet == true else { return }
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.mainGreen.cgColor
        
        setCount.textColor = .gray01
        weight.textColor = .gray01
        kgLabel.textColor = .gray01
        repsNum.textColor = .gray01
        repsLabel.textColor = .gray01
    }
    
    func completedSetAttributes(setData data: SetVolume) {
        guard data.completedSet == true else { return }
        
        layer.borderWidth = 0
        layer.borderColor = .none
        
        backgroundColor = .subGreen02
        
        setCount.textColor = .subGreen01
        weight.textColor = .subGreen01
        kgLabel.textColor = .subGreen01
        repsNum.textColor = .subGreen01
        repsLabel.textColor = .subGreen01
    }
}
