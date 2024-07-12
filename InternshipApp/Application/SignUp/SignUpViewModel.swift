//
//  SignUpViewModel.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 09.07.2024.
//

import UIKit
import FirebaseAuth

final class SignUpViewModel {
    weak var coordinator: SignUpCoordinator?
    
    func createStartCoordinator(navigationController: UINavigationController) {
        
        let startCoordinator = StartCoordinator(navigationController: navigationController)
        startCoordinator.start()
    }
    
    
    func isValidFields(nameTextField: CustomTextField, name: String, emailTextField: CustomTextField, email: String, passwordTextField: CustomTextField, password: String, confirmedPasswordTextField: CustomTextField,confirmedPassword: String) -> Bool {
        let isValidName = isValid(name: name, textField: nameTextField)
        let isValidEmail = isValid(email: email, textField: emailTextField)
        let isValidPassword = isValid(password: password, textField: passwordTextField)
        let areSamePasswords = areSamePasswords(password: password, passwordTextField: passwordTextField, confirmedPassword: confirmedPassword, confirmedPasswordTextField: confirmedPasswordTextField)
        
        return isValidName && isValidEmail && isValidPassword && areSamePasswords
    }
    
    
    func isValid(name: String, textField: CustomTextField) -> Bool {
        let namePredicate = NSPredicate(format: TextValues.selfMatch, Constants.fullNamePattern)
        if namePredicate.evaluate(with: name) {
            return true
        } else {
            textField.changeToRed()
            return false
        }
    }
    
    
    func isValid(email: String, textField: CustomTextField) -> Bool {
        let emailPredicate = NSPredicate(format: TextValues.selfMatch, Constants.emailPattern)
        if emailPredicate.evaluate(with: email) {
            return true
        } else {
            textField.changeToRed()
            return false
        }
    }
    
    
    func isValid(password: String, textField: CustomTextField) -> Bool {
        let passwordPredicate = NSPredicate(format: TextValues.selfMatch, Constants.passwordPattern)
        if passwordPredicate.evaluate(with: password) {
            return true
        } else {
            textField.changeToRed()
            return false
        }
    }
    
    
    func areSamePasswords(password: String, passwordTextField: CustomTextField, confirmedPassword: String, confirmedPasswordTextField: CustomTextField) -> Bool {
        if password != confirmedPassword {
            passwordTextField.changeToRed()
            confirmedPasswordTextField.changeToRed()
            return false
        } else {
            return true
        }
        
    }
    
    
    func createUser(userName: String, email: String, password: String, completion: @escaping(Result<String?, DataBaseError>) -> Void) {
        
        
        FirebaseService.shared.createUser(userName: userName, email: email, password: password) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(_):
                completion(.success(nil))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
