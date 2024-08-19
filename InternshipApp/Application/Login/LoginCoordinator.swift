//
//  LoginCoordinator.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 12.07.2024.
//

import UIKit

final class LoginCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let loginVC = LoginViewController()
        let loginVM = LoginViewModel()
        
        loginVC.vm = loginVM
        loginVC.vm?.coordinator = self
        
        navigationController.pushViewController(loginVC, animated: true)
    }
}
