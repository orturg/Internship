//
//  SelectOptionsCoordinator.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 23.07.2024.
//

import UIKit

class SelectOptionsCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    let popupTransitioningDelegate = PopupTransitioningDelegate()
    weak var delegate: ProfileVCDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let selectOptionsVC = SelectOptionsViewController()
        let selectOptionsVM = SelectOptionsViewModel()
        
        selectOptionsVC.vm = selectOptionsVM
        selectOptionsVC.vm?.coordinator = self
        
        selectOptionsVC.vm?.delegate = delegate
        
        selectOptionsVC.modalPresentationStyle = .custom
        selectOptionsVC.transitioningDelegate = popupTransitioningDelegate
        
        navigationController.present(selectOptionsVC, animated: true)
    }
}
