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
        
        weight.do { $0.setText("", font: .subtitle01, color: .gray04) }
        
        kgLabel.do { $0.setText("kg", font: .subtitle02, color: .gray04) }
        
        repsNum.do { $0.setText("", font: .subtitle01, color: .gray04) }
        
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
            $0.leading.equalTo(setCount.snp.trailing).offset(100)
            $0.centerY.equalToSuperview()
        }
        
        kgLabel.snp.makeConstraints {
            $0.leading.equalTo(weight.snp.trailing).offset(0.5)
            $0.bottom.equalTo(weight).offset(1.5)
        }
        
        slash.snp.makeConstraints {
            $0.leading.equalTo(kgLabel.snp.trailing).offset(35)
            $0.centerY.equalToSuperview().offset(1)
            $0.width.height.equalTo(16)
        }
        
        repsNum.snp.makeConstraints {
            $0.leading.equalTo(slash.snp.trailing).offset(35)
            $0.centerY.equalToSuperview()
        }
        
        repsLabel.snp.makeConstraints {
            $0.leading.equalTo(repsNum.snp.trailing).offset(0.5)
            $0.trailing.equalToSuperview().offset(-33)
            $0.bottom.equalTo(repsNum).offset(1)
        }
    }
}

extension WorkoutSetCell {
    func dataBind(setData data: SetVolume, setNum: Int) {
        setCount.text = "\(setNum + 1)세트"
        weight.text = String(data.weight)
        repsNum.text = String(data.repsNum)
    }
}
