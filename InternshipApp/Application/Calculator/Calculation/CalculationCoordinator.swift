//
//  CalculationCoordinator.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 13.08.2024.
//

import UIKit

final class CalculationCoordinator: Coordinator {
    var navigationController: UINavigationController
    var calculatorType: CalculatorType
    
    init(navigationController: UINavigationController, calculatorType: CalculatorType) {
        self.navigationController = navigationController
        self.calculatorType = calculatorType
    }
    
    func start() {
        let calculationVC = CalculationViewController()
        let calculationVM = CalculationViewModel()
        
        calculationVC.vm = calculationVM
        calculationVC.vm?.coordinator = self
        calculationVC.vm?.calculatorType = calculatorType
        
        navigationController.pushViewController(calculationVC, animated: true)
    }
}
