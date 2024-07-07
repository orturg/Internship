//
//  TabBarController.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 06.07.2024.
//

import UIKit

class TabBarController: UITabBarController {
    var homeNavController: UINavigationController
    var progressNavController: UINavigationController
    var calculatorNavController: UINavigationController
    var musclesNavController: UINavigationController

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    init(homeNavController: UINavigationController, progressNavController: UINavigationController, calculatorNavController: UINavigationController, musclesNavController: UINavigationController) {
        self.homeNavController = homeNavController
        self.progressNavController = progressNavController
        self.calculatorNavController = calculatorNavController
        self.musclesNavController = musclesNavController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        configureTabBar()
    }
    
    
    private func configureTabBar() {
        viewControllers = [homeNavController, progressNavController, calculatorNavController, musclesNavController]
        
        homeNavController.tabBarItem = UITabBarItem(title: "", image: .homeDefault, tag: 0)
        progressNavController.tabBarItem = UITabBarItem(title: "", image: .progressDefault, tag: 1)
        calculatorNavController.tabBarItem = UITabBarItem(title: "", image: .calculatorDefault, tag: 2)
        musclesNavController.tabBarItem = UITabBarItem(title: "", image: .musclesDefault, tag: 3)
        
        tabBar.tintColor = .appYellow
        navigationItem.leftBarButtonItem = UIBarButtonItem()
    }
}
