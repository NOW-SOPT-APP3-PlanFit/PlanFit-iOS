//
//  WorkoutImageCell.swift
//  PlanFit
//
//  Created by 왕정빈 on 5/15/24.
//

import UIKit

import SnapKit

class WorkoutImageCell: UICollectionViewCell, ReuseIdentifiable {
    
    // MARK: - UI Components
    
    private let workOutImage = UIImageView()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setViewHierarchy()
        setAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI Setting

private extension WorkoutImageCell {
    func setViewHierarchy() {
        addSubview(workOutImage)
    }
    
    func setAutoLayout() {
        workOutImage.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}

extension WorkoutImageCell {
    func dataBind(_ data: WorkoutImageData) {
        workOutImage.image = data.workoutImage
    }
}
