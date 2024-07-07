//
//  StartViewModel.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 06.07.2024.
//

import UIKit

class StartViewModel {
    weak var coordinator: StartCoordinator?
    
    func createTabBarCoordinator(navigationController: UINavigationController, titleText: String, isMan: Bool) {
        let tabBarCoordinator = TabBarCoordinator(navigationController: navigationController, titleText: titleText, isMan: isMan)
        tabBarCoordinator.start()
    }
}
