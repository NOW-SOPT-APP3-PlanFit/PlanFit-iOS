//
//  WorkoutImageFooter.swift
//  PlanFit
//
//  Created by 왕정빈 on 5/15/24.
//

import UIKit

import SnapKit

class WorkoutImageFooter: UICollectionReusableView, ReuseIdentifiable {
    
    // MARK: - UI Component
    
    private let pageControl = UIPageControl()
        
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

// MARK: - UI Setting

private extension WorkoutImageFooter {
    func setUI() {
        pageControl.do {
            $0.currentPage = 0
            $0.numberOfPages = 2
            $0.currentPageIndicatorTintColor = .mainGreen
            $0.pageIndicatorTintColor = .gray04
            $0.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        }
    }
    
    func setViewHierarchy() {
        addSubview(pageControl)
    }
    
    func setAutoLayout() {
        pageControl.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
