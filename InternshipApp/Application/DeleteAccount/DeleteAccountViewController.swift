//
//  DeleteAccountViewController.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 02.08.2024.
//

import UIKit

final class DeleteAccountViewController: BaseViewController {
    
    var vm: DeleteAccountViewModel?
    
    @IBOutlet weak var textField: CustomTextField!
    
    private let backButton = UIImageView()
    private let instructionLabel = UILabel()
    private let deleteButton = CustomRoundedRectangleButton(buttonBackgroundColor: .appLightRed, buttonText: TextValues.deleteAccountLabel, textColor: .black, height: Constants.customRoundedRectangleButtonHeight, width: Constants.customRoundedRectangleButtonWidth)
    
    lazy var gradient: GradientView = {
        GradientView(width: Constants.gradientViewWidth, height: view.bounds.height, topColor: .clear, bottomColor: .black)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
    private func configure() {
        configureVC()
        configureBackButton()
        configureTextField()
        configureInstructionLabel()
        configureDeleteButton()
        setupSubviews()
        setupLayoutConstraints()
    }
    
    
    private func configureVC() {
        tabBarController?.tabBar.isHidden = true
    }
    
    
    private func setupSubviews() {
        view.addSubview(gradient)
        view.addSubview(backButton)
        view.addSubview(textField)
        view.addSubview(instructionLabel)
        view.addSubview(deleteButton)
    }
    
    
    private func configureBackButton() {
        backButton.image = UIImage.back
        backButton.isUserInteractionEnabled = true
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissVC))
        backButton.addGestureRecognizer(tapGestureRecognizer)
    }
    
    
    @objc private func dismissVC() {
        navigationController?.popViewController(animated: true)
    }
    
    
    private func configureTextField() {
        textField.setTextFieldTitle(text: TextValues.email)
        textField.setTextFieldPlaceholder(text: TextValues.enterEmail)
    }
    
    
    private func configureInstructionLabel() {
        instructionLabel.text = TextValues.deleteAccountInstructionLabelText
        instructionLabel.textColor = .appSecondary
        instructionLabel.font = UIFont(name: TextValues.sairaThin, size: Constants.deleteAccountInstructionLabelSize)
        instructionLabel.numberOfLines = 0
        instructionLabel.lineBreakMode = .byWordWrapping
        
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func configureDeleteButton() {
        deleteButton.addTarget(self, action: #selector(deleteButtonAction), for: .touchUpInside)
    }
    
    
    @objc private func deleteButtonAction() {
        guard let vm else { return }
        
        if vm.isDeleteButtonActive {
            if vm.isValidEmail(text: textField.getText()) {
                vm.deleteButtonAction(navigationController: navigationController)
            } else {
                textField.changeToRed()
            }
        }
    }
    
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            gradient.topAnchor.constraint(equalTo: view.topAnchor),
            gradient.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradient.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gradient.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 108),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.backButtonLeadingPadding),
            backButton.widthAnchor.constraint(equalToConstant: Constants.backButtonWidth),
            backButton.heightAnchor.constraint(equalToConstant: Constants.backButtonHeight),
            
            instructionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: Constants.instructionLabelTopAnchor),
            instructionLabel.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            instructionLabel.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.deleteAccountVCDeleteButtonBottomAnchor)
        ])
    }
}
