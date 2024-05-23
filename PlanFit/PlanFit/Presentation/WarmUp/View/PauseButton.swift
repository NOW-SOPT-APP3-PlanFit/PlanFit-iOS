//
//  PauseButton.swift
//  PlanFit
//
//  Created by 김진웅 on 5/23/24.
//

import UIKit

final class PauseButton: UIButton {

    // MARK: - Property
    
    var isPlaying: Bool = true {
        didSet {
            let pauseImage = UIImage(resource: .pauseBig).withRenderingMode(.alwaysOriginal)
            let playImage = UIImage(resource: .playBig).withRenderingMode(.alwaysOriginal)
            setImage(isPlaying ? pauseImage : playImage, for: .normal)
        }
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI Setting

private extension PauseButton {
    func setUI() {
        backgroundColor = .gray05
        
        let pauseImage = UIImage(resource: .pauseBig).withRenderingMode(.alwaysOriginal)
        setImage(pauseImage, for: .normal)
        
        layer.cornerRadius = 16
    }
}
