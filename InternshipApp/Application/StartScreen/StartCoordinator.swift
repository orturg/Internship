//
//  StartCoordinator.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 06.07.2024.
//

import UIKit

final class StartCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let startVC = StartViewController()
        let startVM = StartViewModel()
        
        startVC.vm = startVM
        startVC.vm?.coordinator = self
        
        navigationController.pushViewController(startVC, animated: true)
    }
}
