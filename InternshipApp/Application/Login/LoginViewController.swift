//
//  LoginViewController.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 12.07.2024.


import UIKit

final class LoginViewController: BaseViewController {
    
    var vm: LoginViewModel?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet private weak var emailTextField: CustomTextField!
    @IBOutlet private weak var passwordTextField: CustomTextField!
    
    private let loginButton = CustomRoundedRectangleButton(buttonBackgroundColor: .appYellow, buttonText: TextValues.login, textColor: .black, height: Constants.customRoundedRectangleButtonHeight, width: Constants.customRoundedRectangleButtonWidth)
    
    private let forgotPasswordButton = CustomButton(text: TextValues.forgotPassword, color: .appYellow)
    
    private let backToRegisterButton = CustomButton(text: "Back to register", color: .appYellow)
    
    lazy var gradient: GradientView = {
        GradientView(width: Constants.gradientViewWidth, height: view.bounds.height, topColor: .clear, bottomColor: .black)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    
    private func configure() {
        configureVC()
        createDismissTapGesture()
        configureTextFields()
        setupSubviews()
        setupLayoutConstraints()
        configureForgotPasswordButton()
        configureLoginButton()
        configureBackToRegisterButton()
    }
    
    
    private func configureVC() {
        let backBarButtonItem = UIBarButtonItem(customView: UIView())
        navigationItem.leftBarButtonItem = backBarButtonItem
    }
    
    
    private func createDismissTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    private func configureTextFields() {
        vm?.setTextFieldsText(emailTextField: emailTextField, passwordTextField: passwordTextField)
        passwordTextField.setSecureField()
    }
    
    
    private func configureForgotPasswordButton() {
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonAction), for: .touchUpInside)
    }
    
    
    @objc private func forgotPasswordButtonAction() {
        vm?.setResetPasswordVC(navigationController: navigationController)
    }
    
    
    private func configureLoginButton() {
        loginButton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
    }
    
    
    @objc private func loginButtonAction() {
        vm?.login(emailTextField: emailTextField, passwordTextField: passwordTextField, vc: self, loginButton: loginButton, navigationController: navigationController)
    }
    
    
    private func configureBackToRegisterButton() {
        backToRegisterButton.addTarget(self, action: #selector(backToRegisterButtonAction), for: .touchUpInside)
    }
    
    
    @objc private func backToRegisterButtonAction() {
        vm?.backToRegister(navigationController: navigationController)
    }
    
    
    private func setupSubviews() {
        view.addSubview(gradient)
        view.addSubview(titleLabel)
        view.addSubview(loginLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(forgotPasswordButton)
        view.addSubview(loginButton)
        view.addSubview(backToRegisterButton)
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
            
            backToRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backToRegisterButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.backButtonBottomAnchor)
        ])
    }
}
