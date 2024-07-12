//
//  StartViewModel.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 06.07.2024.
//

import UIKit

final class StartViewModel {
    weak var coordinator: StartCoordinator?
    
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
    
    
    func showAlert(vc: UIViewController, error: DataBaseError) {
        let alert = UIAlertController(title: TextValues.error, message: error.rawValue, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        vc.present(alert, animated: true)
    }
}
