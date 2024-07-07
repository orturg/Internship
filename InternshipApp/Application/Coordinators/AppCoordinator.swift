//
//  AppCoordinator.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 29.06.2024.
//

import UIKit

class AppCoordinator: Coordinator {
    private var window: UIWindow?
    
    private var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        
        return navigationController
    }()
    
    
    init(window: UIWindow?) {
        self.window = window
        self.window?.rootViewController = navigationController
    }
    
    
    func start() {
        let startCoordinator = StartCoordinator(navigationController: navigationController)
        startCoordinator.start()
    }
}
