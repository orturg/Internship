//
//  SignUpViewController.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 09.07.2024.
//

import UIKit

final class SignUpViewController: BaseViewController {
    
    var vm: SignUpViewModel?
    
    @IBOutlet private weak var superheroLabel: UILabel!
    @IBOutlet private weak var createYourAccountLabel: UILabel!
    @IBOutlet private weak var nameTextField: CustomTextField!
    @IBOutlet private weak var emailTextField: CustomTextField!
    @IBOutlet private weak var passwordTextField: CustomTextField!
    @IBOutlet private weak var confirmPasswordTextField: CustomTextField!
    @IBOutlet private weak var haveAccountLabel: UILabel!
    
    private let signUpButton = CustomRoundedRectangleButton(buttonBackgroundColor: .appYellow, buttonText: TextValues.signUpButtonText, textColor: .black, height: Constants.customRoundedRectangleButtonHeight, width: Constants.customRoundedRectangleButtonWidth)
    
    private let loginButton = CustomButton(text: TextValues.login, color: .appYellow)
    private var scrollView = UIScrollView()
    private var contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    
    private func configure() {
        configureTextFields()
        setupSubviews()
        configureScrollView()
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
    
    
    private func configureScrollView() {
        scrollView.addSubview(contentView)
        
        contentView.addSubview(superheroLabel)
        contentView.addSubview(createYourAccountLabel)
        contentView.addSubview(nameTextField)
        contentView.addSubview(emailTextField)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(confirmPasswordTextField)
        contentView.addSubview(haveAccountLabel)
        contentView.addSubview(signUpButton)
        contentView.addSubview(loginButton)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func setupSubviews() {
        view.addSubview(scrollView)
    }
    
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            signUpButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: Constants.signUpButtonTopAnchor),
            signUpButton.leadingAnchor.constraint(equalTo: confirmPasswordTextField.leadingAnchor),
            signUpButton.trailingAnchor.constraint(equalTo: confirmPasswordTextField.trailingAnchor),
            
            loginButton.centerYAnchor.constraint(equalTo: haveAccountLabel.centerYAnchor),
            loginButton.leadingAnchor.constraint(equalTo: haveAccountLabel.trailingAnchor, constant: Constants.loginButtonLeadingAnchor),
            loginButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.loginButtonBottomAnchor)
        ])
    }
}
