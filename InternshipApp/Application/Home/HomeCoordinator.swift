//
//  HomeCoordinator.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 29.06.2024.
//

import UIKit

class HomeCoordinator: Coordinator {
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    func start() {
        let homeVC = HomeViewController()
        homeVC.homeCoordinator = self
        navigationController.pushViewController(homeVC, animated: true)
    }
}
