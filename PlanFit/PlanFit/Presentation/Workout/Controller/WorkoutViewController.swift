//
//  WorkoutViewController.swift
//  PlanFit
//
//  Created by 김진웅 on 5/14/24.
//

import UIKit

class WorkoutViewController: UIViewController {
    
    // MARK: - Propertity
    
    private let rootView = WorkoutView()
    
    // MARK: - View Life Cycle
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
    }
    
    // MARK: - NavigationBar Setting
    
    private func setNavigationBar() {
        let headphoneImage = UIImage(resource: .headphone).withRenderingMode(.alwaysOriginal)
        let ellipsisImage = UIImage(resource: .ellipsis).withRenderingMode(.alwaysOriginal)
        let headphoneItem = UIBarButtonItem(image: headphoneImage,
                                            style: .plain,
                                            target: self,
                                            action: nil
        )
        
        let ellipsisItem = UIBarButtonItem(image: ellipsisImage,
                                            style: .plain,
                                            target: self,
                                            action: nil
        )
        
        navigationItem.titleView = rootView.currentTimeView
        navigationItem.rightBarButtonItems = [ellipsisItem, headphoneItem]
    }
}
