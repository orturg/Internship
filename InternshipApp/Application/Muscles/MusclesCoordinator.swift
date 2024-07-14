//
//  MusclesCoordinator.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 06.07.2024.
//

import UIKit

final class MusclesCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    func start() {
        let musclesVC = MusclesViewController()
        let musclesVM = MusclesViewModel()
        
        musclesVC.vm = musclesVM
        musclesVC.vm?.musclesCoordinator = self
        
        navigationController.pushViewController(musclesVC, animated: true)
    }
}
