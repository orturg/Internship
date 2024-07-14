//
//  ProgressCoordinator.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 06.07.2024.
//

import UIKit

final class ProgressCoordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    func start() {
        let progressVC = ProgressViewController()
        let progressVM = ProgressViewModel()
        
        progressVC.vm = progressVM
        progressVC.vm?.progressCoordinator = self
        
        navigationController.pushViewController(progressVC, animated: true)
    }
}
