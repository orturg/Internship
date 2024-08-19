//
//  SignUpCoordinator.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 09.07.2024.
//

import UIKit

final class SignUpCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let signUpVC = SignUpViewController()
        let signUpVM = SignUpViewModel()
        
        signUpVC.vm = signUpVM
        signUpVC.vm?.coordinator = self
        
        navigationController.pushViewController(signUpVC, animated: true)
    }
}
