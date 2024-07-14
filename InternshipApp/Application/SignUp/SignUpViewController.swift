//
//  SignUpViewController.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 09.07.2024.
//

import UIKit

final class SignUpViewController: BaseViewController {
    
    var vm: SignUpViewModel?
    private var scrollView = UIScrollView()
    @IBOutlet private weak var nameTextField: CustomTextField!
    @IBOutlet private weak var emailTextField: CustomTextField!
    @IBOutlet private weak var passwordTextField: CustomTextField!
    @IBOutlet private weak var confirmPasswordTextField: CustomTextField!
    @IBOutlet private weak var haveAccountLabel: UILabel!
    
    private let signUpButton = CustomRoundedRectangleButton(buttonBackgroundColor: .appYellow, buttonText: TextValues.signUpButtonText, textColor: .black, height: Constants.customRoundedRectangleButtonHeight, width: Constants.customRoundedRectangleButtonWidth)
    
    private let loginButton = CustomButton(text: TextValues.login, color: .appYellow)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    
    private func configure() {
        configureTextFields()
        setupSubviews()
        setupLayoutConstraints()
        configureButtons()
    }
    
    
    private func configureTextFields() {
        nameTextField.setTextFieldTitle(text: TextValues.name)
        nameTextField.setTextFieldPlaceholder(text: TextValues.enterName)
        
        emailTextField.setTextFieldTitle(text: TextValues.email)
        emailTextField.setTextFieldPlaceholder(text: TextValues.enterEmail)
        
        passwordTextField.setTextFieldTitle(text: TextValues.password)
        passwordTextField.setTextFieldPlaceholder(text: TextValues.createPassword)
        passwordTextField.setSecureField()
        
        confirmPasswordTextField.setTextFieldTitle(text: TextValues.confirmPassword)
        confirmPasswordTextField.setTextFieldPlaceholder(text: TextValues.enterPassword)
        confirmPasswordTextField.setSecureField()
    }
    
    
    private func configureButtons() {
        configureSignUpButton()
        configureLoginButton()
    }
    
    
    private func configureSignUpButton() {
        signUpButton.addTarget(self, action: #selector(signUpButtonAction), for: .touchUpInside)
    }
    
    
    private func configureLoginButton() {
        loginButton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
    }
    
    
    @objc private func signUpButtonAction() {
        vm?.signUpButtonAction(nameTextField: nameTextField, emailTextField: emailTextField, passwordTextField: passwordTextField, confirmPasswordTextField: confirmPasswordTextField, signUpButton: signUpButton, navigationController: navigationController)
    }
    
    
    @objc private func loginButtonAction() {
        vm?.loginButtonAction(navigationController: navigationController)
    }
    
    
    private func setupSubviews() {
        view.addSubview(signUpButton)
        view.addSubview(loginButton)
    }
    
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: Constants.signUpButtonTopAnchor),
            signUpButton.leadingAnchor.constraint(equalTo: confirmPasswordTextField.leadingAnchor),
            signUpButton.trailingAnchor.constraint(equalTo: confirmPasswordTextField.trailingAnchor),
            
            loginButton.topAnchor.constraint(equalTo: haveAccountLabel.topAnchor),
            loginButton.leadingAnchor.constraint(equalTo: haveAccountLabel.trailingAnchor, constant: Constants.loginButtonLeadingAnchor),
            loginButton.bottomAnchor.constraint(equalTo: haveAccountLabel.bottomAnchor)
        ])
    }
}
