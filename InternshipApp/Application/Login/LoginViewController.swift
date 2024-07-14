//
//  LoginViewController.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 12.07.2024.
//

import UIKit

final class LoginViewController: BaseViewController {
    
    var vm: LoginViewModel?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet private weak var emailTextField: CustomTextField!
    @IBOutlet private weak var passwordTextField: CustomTextField!
    
    private let loginButton = CustomRoundedRectangleButton(buttonBackgroundColor: .appYellow, buttonText: TextValues.login, textColor: .black, height: Constants.customRoundedRectangleButtonHeight, width: Constants.customRoundedRectangleButtonWidth)
    
    lazy var gradient: GradientView = {
        GradientView(width: Constants.gradientViewWidth, height: view.bounds.height, topColor: .clear, bottomColor: .black)
    }()
    
    private let forgotPasswordButton = CustomButton(text: TextValues.forgotPassword, color: .appYellow)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    
    private func configure() {
        configureVC()
        configureTextFields()
        setupSubviews()
        setupLayoutConstraints()
        configureLoginButton()
    }
    
    
    private func configureVC() {
        let backBarButtonItem = UIBarButtonItem(customView: UIView())
        navigationItem.leftBarButtonItem = backBarButtonItem
    }
    
    
    private func configureTextFields() {
        emailTextField.setTextFieldTitle(text: TextValues.email)
        emailTextField.setTextFieldPlaceholder(text: TextValues.enterName)
        
        passwordTextField.setTextFieldTitle(text: TextValues.password)
        passwordTextField.setTextFieldPlaceholder(text: TextValues.enterPassword)
        passwordTextField.setSecureField()
    }
    
    
    private func configureLoginButton() {
        loginButton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
    }
    
    
    @objc private func loginButtonAction() {
        vm?.login(email: emailTextField.getText(), password: passwordTextField.getText(), vc: self, navigationController: navigationController)
    }
    
    
    private func setupSubviews() {
        view.addSubview(gradient)
        view.addSubview(titleLabel)
        view.addSubview(loginLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(forgotPasswordButton)
        view.addSubview(loginButton)
    }
    
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            gradient.topAnchor.constraint(equalTo: view.topAnchor),
            gradient.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradient.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gradient.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            forgotPasswordButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: Constants.forgotPasswordTopAnchorPadding),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            
            loginButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: Constants.loginButtonTopAnchor),
            loginButton.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
        ])
    }
}
