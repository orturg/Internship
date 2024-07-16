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
    
    
    func signUpButtonAction(nameTextField: CustomTextField, emailTextField: CustomTextField, passwordTextField: CustomTextField, confirmPasswordTextField: CustomTextField, signUpButton: CustomRoundedRectangleButton, navigationController: UINavigationController?) {
        guard let navigationController else { return }
        
        let name = nameTextField.getText()
        let email = emailTextField.getText()
        let password = passwordTextField.getText()
        let confirmedPassword = confirmPasswordTextField.getText()
        
        
        guard isValidFields(nameTextField: nameTextField, name: name, emailTextField: emailTextField, email: email, passwordTextField: passwordTextField, password: password, confirmedPasswordTextField: confirmPasswordTextField, confirmedPassword: confirmedPassword) else { return }
        
        signUpButton.isEnabled = false
        
        createUser(userName: nameTextField.getText(), email: emailTextField.getText(), password: passwordTextField.getText()) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(_):
                createStartCoordinator(navigationController: navigationController)
                signUpButton.isEnabled = true
            case .failure(_):
                signUpButton.isEnabled = true
            }
        }
    }
    
    
    func loginButtonAction(navigationController: UINavigationController?) {
        guard let navigationController else { return }
        
        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
        loginCoordinator.start()
    }
    
    
    func setTextFieldsText(nameTextField: CustomTextField, emailTextField: CustomTextField, passwordTextField: CustomTextField, confirmPasswordTextField: CustomTextField) {
        nameTextField.setTextFieldTitle(text: TextValues.name)
        nameTextField.setTextFieldPlaceholder(text: TextValues.enterName)
        
        emailTextField.setTextFieldTitle(text: TextValues.email)
        emailTextField.setTextFieldPlaceholder(text: TextValues.enterEmail)
        
        passwordTextField.setTextFieldTitle(text: TextValues.password)
        passwordTextField.setTextFieldPlaceholder(text: TextValues.createPassword)
        
        confirmPasswordTextField.setTextFieldTitle(text: TextValues.confirmPassword)
        confirmPasswordTextField.setTextFieldPlaceholder(text: TextValues.enterPassword)
    }
    
    
    private func isValidFields(nameTextField: CustomTextField, name: String, emailTextField: CustomTextField, email: String, passwordTextField: CustomTextField, password: String, confirmedPasswordTextField: CustomTextField,confirmedPassword: String) -> Bool {
        let isValidName = isValid(name: name, textField: nameTextField)
        let isValidEmail = isValid(email: email, textField: emailTextField)
        let isValidPassword = isValid(password: password, textField: passwordTextField)
        let areSamePasswords = areSamePasswords(password: password, passwordTextField: passwordTextField, confirmedPassword: confirmedPassword, confirmedPasswordTextField: confirmedPasswordTextField)
        
        return isValidName && isValidEmail && isValidPassword && areSamePasswords
    }
    
    
    private func isValid(name: String, textField: CustomTextField) -> Bool {
        let namePredicate = NSPredicate(format: TextValues.selfMatch, Constants.fullNamePattern)
        if namePredicate.evaluate(with: name) {
            return true
        } else {
            textField.changeToRed()
            return false
        }
    }
    
    
    private func isValid(email: String, textField: CustomTextField) -> Bool {
        let emailPredicate = NSPredicate(format: TextValues.selfMatch, Constants.emailPattern)
        if emailPredicate.evaluate(with: email) {
            return true
        } else {
            textField.changeToRed()
            return false
        }
    }
    
    
    private func isValid(password: String, textField: CustomTextField) -> Bool {
        let passwordPredicate = NSPredicate(format: TextValues.selfMatch, Constants.passwordPattern)
        if passwordPredicate.evaluate(with: password) {
            return true
        } else {
            textField.changeToRed()
            return false
        }
    }
    
    
    private func areSamePasswords(password: String, passwordTextField: CustomTextField, confirmedPassword: String, confirmedPasswordTextField: CustomTextField) -> Bool {
        if password != confirmedPassword {
            passwordTextField.changeToRed()
            confirmedPasswordTextField.changeToRed()
            return false
        } else {
            return true
        }
        
    }
    
    
    private func createUser(userName: String, email: String, password: String, completion: @escaping(Result<String?, DataBaseError>) -> Void) {
        
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
