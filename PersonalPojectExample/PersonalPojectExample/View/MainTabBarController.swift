//
//  MainTabBarController.swift
//  PersonalPojectExample
//
//  Created by 김시훈 on 2023/03/13.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let viewControllers = viewControllers {
            for viewController in viewControllers {
                // MARK: - 왜 로드되지 않는가
                let _ = viewController.view
//                viewController.loadViewIfNeeded()
//                print(#function,"tabbar")
            }
        }
    }
}
