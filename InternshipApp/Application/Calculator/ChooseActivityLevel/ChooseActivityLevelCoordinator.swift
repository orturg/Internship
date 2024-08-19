//
//  ChooseActivityLevelCoordinator.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 15.08.2024.
//

import UIKit

final class ChooseActivityLevelCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    let popupTransitioningDelegate = PopupTransitioningDelegate()
    weak var chooseActivityDelegate: ChooseActivityDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    func start() {
        let chooseActivityLevelVC = ChooseActivityLevelViewController()
        let chooseActivityLevelVM = ChooseActivityLevelViewModel()
        
        chooseActivityLevelVC.vm = chooseActivityLevelVM
        chooseActivityLevelVC.vm?.coordinator = self
        chooseActivityLevelVC.vm?.chooseActivityDelegate = chooseActivityDelegate
        
        chooseActivityLevelVC.modalPresentationStyle = .custom
        chooseActivityLevelVC.transitioningDelegate = popupTransitioningDelegate
        
        navigationController.present(chooseActivityLevelVC, animated: true)
    }
}
