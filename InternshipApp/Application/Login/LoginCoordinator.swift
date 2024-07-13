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
        var loginVC = LoginViewController()
        var loginVM = LoginViewModel()
        
        loginVC.vm = loginVM
        loginVC.vm?.coordinator = self
        
        navigationController.pushViewController(loginVC, animated: true)
    }
}
