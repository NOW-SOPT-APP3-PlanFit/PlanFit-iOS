//
//  StampButton.swift
//  PlanFit
//
//  Created by 김진웅 on 5/17/24.
//

import UIKit

final class StampButton: UIButton {

    // MARK: - Property
    
    private var isActive: Bool = false {
        didSet {
            let image = UIImage(resource: isActive ? .stampActive : .stampInactive)
                .withRenderingMode(.alwaysOriginal)
            setImage(image, for: .disabled)
        }
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setUI()
        setAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func activate() {
        isActive.toggle()
    }
}

// MARK: - UISetting

private extension StampButton {
    func setUI() {
        isEnabled = false
        let image = UIImage(resource: .stampInactive).withRenderingMode(.alwaysOriginal)
        setImage(image, for: .disabled)
    }
    
    func setAutoLayout() {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: heightAnchor, multiplier: 1)
        ])
    }
}
