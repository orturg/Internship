//
//  StartViewModel.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 06.07.2024.
//

import UIKit

final class StartViewModel {
    weak var coordinator: StartCoordinator?
    var navigationController: UINavigationController?
    var superManButton: CustomRoundedRectangleButton?
    var superGirlButton: CustomRoundedRectangleButton?
    var vc: UIViewController?
    
    func createTabBarCoordinator(navigationController: UINavigationController, titleText: String, isMan: Bool) {
        let tabBarCoordinator = TabBarCoordinator(navigationController: navigationController, titleText: titleText, isMan: isMan)
        tabBarCoordinator.start()
    }
    
    
    func updateUser(sex: String, completion: @escaping (Result<String?, DataBaseError>) -> Void) {
        FirebaseService.shared.updateUser(with: sex) { result in
            switch result {
            case .success(_):
                completion(.success(nil))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    func superManButtonAction(navigationController: UINavigationController?, superManButton: CustomRoundedRectangleButton, superGirlButton: CustomRoundedRectangleButton, vc: UIViewController) {
        guard let navigationController else { return }
        
        updateUser(sex: TextValues.male) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(_):
                createTabBarCoordinator(navigationController: navigationController, titleText: TextValues.superManLabel, isMan: true)
                superManButton.isEnabled = true
                superGirlButton.isEnabled = true
            case .failure(let error):
                vc.showAlert(vc: vc, error: error)
                superManButton.isEnabled = true
                superGirlButton.isEnabled = true
            }
        }
    }
    
    
    func superGirlButtonAction(navigationController: UINavigationController?, superManButton: CustomRoundedRectangleButton, superGirlButton: CustomRoundedRectangleButton, vc: UIViewController) {
        guard let navigationController else { return }
        
        updateUser(sex: TextValues.female) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(_):
                createTabBarCoordinator(navigationController: navigationController, titleText: TextValues.superGirlLabel, isMan: false)
                superManButton.isEnabled = true
                superGirlButton.isEnabled = true
            case .failure(let error):
                vc.showAlert(vc: vc, error: error)
                superManButton.isEnabled = true
                superGirlButton.isEnabled = true
            }
        }
    }
}
