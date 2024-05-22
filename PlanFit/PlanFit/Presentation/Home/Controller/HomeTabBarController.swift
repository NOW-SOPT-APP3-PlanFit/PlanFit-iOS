//
//  HomeTabBarController.swift
//  PlanFit
//
//  Created by 김진웅 on 5/20/24.
//

import UIKit

final class HomeTabBarController: UITabBarController {
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        addLayer()
    }
}

extension HomeTabBarController: ExerciseNavigationDelegate {
    func moveToWorkoutList() {
        let viewController = WorkoutListViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UISetting

private extension HomeTabBarController {
    func setUI() {
        tabBar.do {
            $0.backgroundColor = .gray08BG
            $0.barTintColor = .gray08BG
            $0.tintColor = .gray01
            $0.unselectedItemTintColor = .gray04
            $0.itemWidth = Screen.width(44)
            $0.itemSpacing = Screen.width(32)
            $0.itemPositioning = .centered
        }
        
        let tabBarItemsInfo: [(title: String, image: UIImage, tag: Int)] = [
            (title: "운동", image: .exercise, tag: 0),
            (title: "분석", image: .analysis, tag: 1),
            (title: "커뮤니티", image: .community, tag: 2),
            (title: "프로필", image: .profile.withRenderingMode(.alwaysOriginal), tag: 3)
        ]
        
        let rootViewControllers = [
            ExerciseViewController(delegate: self),
            ViewController(),
            ViewController(),
            ViewController()
        ]
        
        viewControllers = zip(rootViewControllers, tabBarItemsInfo).map { viewController, itemInfo in
            let (title, image, tag) = itemInfo
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.neoFont(for: .caption03),
                .kern: UIFont.NeoFont.caption03.kern
            ]
            
            let item = UITabBarItem(title: title, image: image, tag: tag)
            item.setTitleTextAttributes(attributes, for: .normal)
            item.setTitleTextAttributes(attributes, for: .selected)
            
            viewController.tabBarItem = item
            if viewController === ExerciseViewController.self {
                return viewController
            }
            return UINavigationController(rootViewController: viewController)
        }
    }
    
    func addLayer() {
        let shapeLayer = CAShapeLayer()
        let baseWidth = Screen.width(347)
        let baseHeight = Screen.height(70)
        shapeLayer.path = UIBezierPath(
            roundedRect: CGRect(x: 0, y: 0, width: baseWidth, height: baseHeight),
            cornerRadius: 50
        ).cgPath
        shapeLayer.fillColor = UIColor.gray07.cgColor
        
        let tabBarWidth = tabBar.bounds.width
        let tabBarHeight = tabBar.bounds.height
        let posX = (tabBarWidth / 2) - (baseWidth / 2)
        let posY = tabBarHeight - 60
        
        shapeLayer.frame = CGRect(x: posX, y: posY, width: baseWidth, height: baseHeight)
        tabBar.layer.insertSublayer(shapeLayer, at: 0)
    }
}
