//
//  HomeCoordinator.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 29.06.2024.
//

import UIKit

final class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController
    var titleText: String?
    var isMan: Bool
    
    init(navigationController: UINavigationController, titleText: String?, isMan: Bool) {
        self.navigationController = navigationController
        self.titleText = titleText
        self.isMan = isMan
    }
    
    
    func start() {
        let homeVC = HomeViewController()
        let homeVM = HomeViewModel(titleText: titleText, isMan: isMan)
        
        homeVC.vm = homeVM
        homeVC.vm?.homeCoordinator = self
        
        navigationController.pushViewController(homeVC, animated: true)
    }
}
