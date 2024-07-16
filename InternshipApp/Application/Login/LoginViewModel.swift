//
//  LoginViewModel.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 12.07.2024.
//

import UIKit

final class LoginViewModel {
    weak var coordinator: LoginCoordinator?
    
    
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
    
    
    func login(emailTextField: CustomTextField, passwordTextField: CustomTextField, vc: UIViewController, loginButton: CustomRoundedRectangleButton, navigationController: UINavigationController?) {
        
        let email = emailTextField.getText()
        let password = passwordTextField.getText()
        
        
        guard isValidFields(emailTextField: emailTextField, email: email, passwordTextField: passwordTextField, password: password) else { return }
        
        loginButton.isEnabled = false
        
        FirebaseService.shared.login(email: email, password: password) { [weak self] result in
            guard let self else { return }
            guard let navigationController else { return }
            
            switch result {
            case .success(_):
                loginButton.isEnabled = true
                self.createNewScreen(navigationController: navigationController)
            case .failure(let error):
                loginButton.isEnabled = true
                vc.showAlert(vc: vc, error: error)
            }
        }
    }
    
    
    private func isValidFields(emailTextField: CustomTextField, email: String, passwordTextField: CustomTextField, password: String) -> Bool {
        let isValidEmail = isValid(email: email, textField: emailTextField)
        let isValidPassword = isValid(password: password, textField: passwordTextField)
        
        return isValidEmail && isValidPassword
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
    
    
    func setTextFieldsText(emailTextField: CustomTextField, passwordTextField: CustomTextField) {
        emailTextField.setTextFieldTitle(text: TextValues.email)
        emailTextField.setTextFieldPlaceholder(text: TextValues.enterEmail)
        
        passwordTextField.setTextFieldTitle(text: TextValues.password)
        passwordTextField.setTextFieldPlaceholder(text: TextValues.createPassword)
    }
    
    
    func backToRegister(navigationController: UINavigationController?) {
        navigationController?.popViewController(animated: true)
    }
    
    
    func setResetPasswordVC(navigationController: UINavigationController?) {
        guard let navigationController else { return }
        
        let resetPasswordCoordinator = ResetPasswordCoordinator(navigationController: navigationController)
        resetPasswordCoordinator.start()
    }
}
