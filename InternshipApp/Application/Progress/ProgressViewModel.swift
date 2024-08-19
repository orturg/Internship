//
//  ProgressViewModel.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 06.07.2024.
//

import UIKit

final class ProgressViewModel {
    weak var progressCoordinator: ProgressCoordinator?
    var optionData: [OptionData] = []
    var isOptionDataEmpty = true
    
    func getCells(completion: @escaping () -> Void) {
        optionData.removeAll()
        
        FirebaseService.shared.getOptionData { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let options):
                guard let options else {
                    isOptionDataEmpty = true
                    completion()
                    return
                }
                guard !options.isEmpty else {
                    isOptionDataEmpty = true
                    completion()
                    return
                }
                
                self.optionData = options
                isOptionDataEmpty = false
                completion()
            case .failure(_):
                completion()
            }
        }
    }
    
    
    func tapCellAction(navigationController: UINavigationController?, optionData: OptionData?) {
        guard let navigationController else { return }
        
        let progressChartScreenVC = ProgressChartScreenCoordinator(navigationController: navigationController, optionData: optionData)
        progressChartScreenVC.start()
    }
}
