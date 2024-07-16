//
//  ResetPasswordCoordinator.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 16.07.2024.
//

import UIKit

final class ResetPasswordCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let resetPasswordVC = ResetPasswordViewController()
        let resetPasswordVM = ResetPasswordViewModel()
        
        resetPasswordVC.vm = resetPasswordVM
        resetPasswordVC.vm?.coordinator = self
        
        navigationController.pushViewController(resetPasswordVC, animated: true)
    }
}
