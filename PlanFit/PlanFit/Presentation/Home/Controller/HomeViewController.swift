//
//  HomeViewController.swift
//  PlanFit
//
//  Created by 김진웅 on 5/14/24.
//

import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: - UIComponent
    
    private let rootView = HomeRootView()
    
    // MARK: - Property
    
    
    // MARK: - LifeCycle
    
    override func loadView() {
        super.loadView()
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
    }
}

// MARK: - UISetting

private extension HomeViewController {
    func setNavigationBar() {
        let categoryButton = UIButton().then {
            var configuration = UIButton.Configuration.plain()
            configuration.imagePlacement = .trailing
            configuration.imagePadding = 5
            configuration.baseForegroundColor = .gray01
            $0.configuration = configuration
            $0.setTitle("헬스", font: .head02, titleColor: .gray01)
            $0.setImage(.arrowBottom, for: .normal)
        }
        
        let premiumButton = UIButton().then {
            $0.setBackgroundImage(.btnPremium, for: .normal)
            $0.frame = CGRect(x: 0, y: 0, width: Screen.width(90), height: Screen.height(27))
        }
        
        let settingsButton = UIButton().then {
            $0.setBackgroundImage(.settings, for: .normal)
            $0.frame = CGRect(x: 0, y: 0, width: Screen.width(20), height: Screen.height(20))
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: categoryButton)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: settingsButton),
            UIBarButtonItem(customView: premiumButton)
        ]
        
        let navigationBarSeparator = UIView(frame: CGRect(
            x: 0,
            y: navigationController!.navigationBar.frame.height + 1,
            width: navigationController!.navigationBar.frame.width,
            height: 0.2
        ))
        navigationBarSeparator.backgroundColor = .gray
        navigationBarSeparator.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        navigationController?.navigationBar.addSubview(navigationBarSeparator)
    }
}
