//
//  CalculatorCoordinator.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 06.07.2024.
//

import UIKit

class CalculatorCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let calculatorVC = CalculatorViewController()
        let calculatorVM = CalculatorViewModel()
        
        calculatorVC.vm = calculatorVM
        calculatorVC.vm?.calculatorCoordinator = self
        
        navigationController.pushViewController(calculatorVC, animated: true)
    }
    
    
}
