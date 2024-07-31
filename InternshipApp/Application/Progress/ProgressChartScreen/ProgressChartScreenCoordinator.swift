//
//  ProgressChartScreenCoordinator.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 30.07.2024.
//

import UIKit

final class ProgressChartScreenCoordinator: Coordinator {
    var navigationController: UINavigationController
    var optionData: OptionData?
    
    init(navigationController: UINavigationController, optionData: OptionData?) {
        self.navigationController = navigationController
        self.optionData = optionData
    }
    
    func start() {
        let progressChartScreenVC = ProgressChartScreenViewController()
        let progressChartScreenVM = ProgressChartScreenViewModel()
        
        progressChartScreenVC.vm = progressChartScreenVM
        progressChartScreenVC.vm?.coordinator = self
        progressChartScreenVC.vm?.optionData = optionData
        
        navigationController.pushViewController(progressChartScreenVC, animated: true)
    }
}
