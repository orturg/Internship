//
//  ProfileCoordinator.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 21.07.2024.
//

import UIKit

final class ProfileCoordinator: Coordinator {
    var navigationController: UINavigationController
    var isMan: Bool
    
    init(navigationController: UINavigationController, isMan: Bool) {
        self.navigationController = navigationController
        self.isMan = isMan
    }
    
    func start() {
        let profileVC = ProfileViewController()
        let profileVM = ProfileViewModel(isMan: isMan)
        
        profileVC.vm = profileVM
        profileVC.vm?.coordinator = self
        
        navigationController.pushViewController(profileVC, animated: true)
    }
}
