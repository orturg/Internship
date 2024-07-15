//
//  LoginViewModel.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 12.07.2024.
//

import UIKit

final class LoginViewModel {
    weak var coordinator: LoginCoordinator?
    
    func login(email: String, password: String, vc: UIViewController, navigationController: UINavigationController?) {
        FirebaseService.shared.login(email: email, password: password) { [weak self] result in
            guard let self else { return }
            guard let navigationController else { return }
            
            switch result {
            case .success(_):
                self.createNewScreen(navigationController: navigationController)
            case .failure(let error):
                vc.showAlert(vc: vc, error: error)
            }
        }
    }
    
    
    private func createNewScreen(navigationController: UINavigationController) {
        getUser(navigationController: navigationController) { [weak self] user in
            guard let self = self else { return }
            guard let user else {
                return
            }
            if let sex = user.sex, !sex.isEmpty {
                let tabBarCoordinator = TabBarCoordinator(navigationController: navigationController, titleText: user.sex == TextValues.male ? TextValues.superManLabel : TextValues.superGirlLabel, isMan: user.sex == TextValues.male)
                tabBarCoordinator.start()
            } else {
                let startCoordinator = StartCoordinator(navigationController: navigationController)
                startCoordinator.start()
            }
        }
    }
    
    
    private func getUser(navigationController: UINavigationController, completion: @escaping (RegistrationData?) -> Void) {
        FirebaseService.shared.getUser { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let user):
                completion(user)
            case .failure(let error):
                navigationController.showAlert(vc: navigationController, error: error)
            }
        }
    }
    
    
    func setTextFieldsText(emailTextField: CustomTextField, passwordTextField: CustomTextField) {
        emailTextField.setTextFieldTitle(text: TextValues.email)
        emailTextField.setTextFieldPlaceholder(text: TextValues.enterEmail)
        
        passwordTextField.setTextFieldTitle(text: TextValues.password)
        passwordTextField.setTextFieldPlaceholder(text: TextValues.createPassword)
    }
}
