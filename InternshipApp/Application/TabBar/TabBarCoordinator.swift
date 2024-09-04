//
//  TabBarCoordinator.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 06.07.2024.
//

import UIKit

final class TabBarCoordinator: Coordinator {
    private var navigationController: UINavigationController
    let homeNavController = UINavigationController()
    let progressNavController = UINavigationController()
    let calculatorNavController = UINavigationController()
    let musclesNavController = UINavigationController()
    var isMan: Bool = true
    var titleText: String?
    
    init(navigationController: UINavigationController, titleText: String, isMan: Bool) {
        self.navigationController = navigationController
        self.titleText = titleText
        self.isMan = isMan
    }
    
    
    func start() {
        let homeCoordinator = HomeCoordinator(navigationController: homeNavController, titleText: titleText, isMan: isMan)
        
        homeCoordinator.start()
        
        let progressCoordinator = ProgressCoordinator(navigationController: progressNavController)
        progressCoordinator.start()
       
        let calculatorCoordinator = CalculatorCoordinator(navigationController: calculatorNavController)
        calculatorCoordinator.start()
        
        let musclesCoordinator = MusclesCoordinator(navigationController: musclesNavController)
        musclesCoordinator.start()
        
        let tabBarController = TabBarController(
            homeNavController: homeNavController,
            progressNavController: progressNavController,
            calculatorNavController: calculatorNavController,
            musclesNavController: musclesNavController
        )
        
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
        
        sceneDelegate.window?.rootViewController = tabBarController
        sceneDelegate.window?.makeKeyAndVisible()
    }
}
