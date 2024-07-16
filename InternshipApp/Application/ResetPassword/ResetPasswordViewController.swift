//
//  ResetPasswordViewController.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 16.07.2024.
//

import UIKit

final class ResetPasswordViewController: BaseViewController {

    var vm: ResetPasswordViewModel?
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    @IBOutlet private weak var forgotPasswordLabel: UILabel!
    
    @IBOutlet private weak var emailTextField: CustomTextField!
    
    private let instructionLabel = UILabel()
    private let continueButton = CustomRoundedRectangleButton(buttonBackgroundColor: .appYellow, buttonText: TextValues.continueLabel, textColor: .black, height: Constants.customRoundedRectangleButtonHeight, width: Constants.customRoundedRectangleButtonWidth)
    
    private let backToLoginButton = CustomButton(text: "Back to login", color: .appYellow)
    
    lazy var gradient: GradientView = {
        GradientView(width: Constants.gradientViewWidth, height: view.bounds.height, topColor: .clear, bottomColor: .black)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    
    private func configure() {
        configureVC()
        setTextFieldLabels()
        configureInstruction()
        configureContinueButton()
        configureBackToLoginButton()
        setupSubviews()
        setupLayoutConstraints()
    }
    
    
    private func configureVC() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIView())
    }
    
    
    private func setupSubviews() {
        view.addSubview(gradient)
        view.addSubview(instructionLabel)
        view.addSubview(continueButton)
        view.addSubview(backToLoginButton)
        view.addSubview(emailTextField)
    }
    
    
    private func setTextFieldLabels() {
        vm?.setTextFieldsLabel(emailTextField: emailTextField)
    }
    
    
    private func configureInstruction() {
        instructionLabel.text = TextValues.forgotPasswordInstructionLabelText
        instructionLabel.textColor = .appSecondary
        instructionLabel.font = UIFont(name: TextValues.sairaRegular, size: Constants.forgotPasswordInstructionLabelSize)
        instructionLabel.numberOfLines = 0
        instructionLabel.lineBreakMode = .byWordWrapping
        
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func configureContinueButton() {
        continueButton.addTarget(self, action: #selector(continueButtonAction), for: .touchUpInside)
    }
    
    
    @objc private func continueButtonAction() {
        vm?.continueButtonAction(emailTextField: emailTextField, continueButton: continueButton, vc: self)
    }
    
    
    private func configureBackToLoginButton() {
        backToLoginButton.addTarget(self, action: #selector(backToLoginButtonAction), for: .touchUpInside)
    }
    
    
    @objc private func backToLoginButtonAction() {
        vm?.backToLogin(navigationController: navigationController)
    }
    
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            gradient.topAnchor.constraint(equalTo: view.topAnchor),
            gradient.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradient.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gradient.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            instructionLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: Constants.instructionLabelTopAnchor),
            instructionLabel.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            instructionLabel.widthAnchor.constraint(equalToConstant: Constants.instructionLabelWidth),
            
            continueButton.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: Constants.continueButtonTopAnchor),
            continueButton.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            continueButton.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            
            backToLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backToLoginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.backButtonBottomAnchor)
            
        ])
    }
}
