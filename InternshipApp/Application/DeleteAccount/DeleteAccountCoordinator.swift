//
//  DeleteAccountCoordinator.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 02.08.2024.
//

import UIKit

final class DeleteAccountCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let deleteAccountVC = DeleteAccountViewController()
        let deleteAccountVM = DeleteAccountViewModel()
        
        deleteAccountVC.vm = deleteAccountVM
        deleteAccountVC.vm?.coordinator = self
        
        navigationController.pushViewController(deleteAccountVC, animated: true)
    }
}
