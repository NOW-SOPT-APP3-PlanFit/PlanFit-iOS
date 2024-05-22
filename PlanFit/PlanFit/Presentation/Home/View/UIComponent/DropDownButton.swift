//
//  DropDownButton.swift
//  PlanFit
//
//  Created by 김진웅 on 5/17/24.
//

import UIKit

import SnapKit

final class DropDownButton: UIButton {

    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UISetting

private extension DropDownButton {
    func setUI() {
        var configuration = UIButton.Configuration.plain()
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 4
        configuration.baseForegroundColor = .mainGreen
        self.configuration = configuration
        
        let image = UIImage(resource: .triangle).withTintColor(.gray04, renderingMode: .alwaysOriginal)
        setImage(image, for: .normal)
        backgroundColor = .gray06
        layer.cornerRadius = 10
    }
    
    func setAutoLayout() {
        self.snp.makeConstraints {
            $0.height.equalTo(Screen.height(32))
        }
    }
}
