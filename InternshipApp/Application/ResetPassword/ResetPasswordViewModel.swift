//
//  ResetPasswordViewModel.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 16.07.2024.
//

import UIKit

final class ResetPasswordViewModel {
    weak var coordinator: ResetPasswordCoordinator?
    weak var resetPasswordVCDelegate: ResetPasswordVCDelegate?
    
    func setTextFieldsLabel(emailTextField: CustomTextField) {
        emailTextField.setTextFieldTitle(text: TextValues.email)
        emailTextField.setTextFieldPlaceholder(text: TextValues.enterEmail)
    }
    
    
    func backToLogin(navigationController: UINavigationController?) {
        guard let navigationController else { return }
        
        navigationController.popViewController(animated: true)
    }
    
    
    func continueButtonAction(emailTextField: CustomTextField, continueButton: CustomRoundedRectangleButton, navigationController: UINavigationController?) {
        let email = emailTextField.getText()
        
        guard isValidFields(emailTextField: emailTextField, email: email) else { return }
        
        continueButton.isEnabled = false
        
        FirebaseService.shared.resetPassword(email: email) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(_):
                self.showSuccessAlert(navigationController: navigationController)
            case .failure(_):
                self.showFailureAlert(navigationController: navigationController)
            }
            continueButton.isEnabled = true
        }
        
    }
    
    
    private func showSuccessAlert(navigationController: UINavigationController?) {
        guard let navigationController else { return }
        
        let alertCoordinator = CustomAlertCoordinator(navigationController: navigationController, isSuccessAlert: true, messageText: TextValues.successResetMessage)
        alertCoordinator.start()
    }
    
    
    private func showFailureAlert(navigationController: UINavigationController?) {
        guard let navigationController else { return }

        let alertCoordinator = CustomAlertCoordinator(navigationController: navigationController, isSuccessAlert: false, messageText: TextValues.failedResetMessage)
        alertCoordinator.delegate = resetPasswordVCDelegate
        alertCoordinator.start()
    }
    
    
    private func isValidFields(emailTextField: CustomTextField, email: String) -> Bool {
        let isValidEmail = isValid(email: email, textField: emailTextField)
        
        return isValidEmail
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
    
}
