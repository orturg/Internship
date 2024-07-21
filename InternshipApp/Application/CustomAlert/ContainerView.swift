//
//  ContainerView.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 16.07.2024.
//

import UIKit

final class ContainerView: UIView {
    
    var vm: CustomAlertViewModel?
    
    private let okButton = CustomRoundedRectangleButton(buttonBackgroundColor: .appYellow, buttonText: TextValues.ok, textColor: .black, height: Constants.customRoundedRectangleButtonHeight, width: Constants.customAlertRoundedRectangleButtonWidth)
    
    private var cancelButton: CustomButton? = CustomButton()
    private var messageText: String
    private var isSuccessAlert: Bool
    private var messageLabel = UILabel()
    private let alertVC: CustomAlertVC
    
    
    init(messageText: String, isSuccessAlert: Bool, alertVC: CustomAlertVC) {
        self.messageText = messageText
        self.isSuccessAlert = isSuccessAlert
        self.alertVC = alertVC
        super.init(frame: .zero)
        configure()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        configureContainer()
        configureMessageLabel()
        configureOkButton()
        configureCancelButton()
        setupSubviews()
        setupLayoutConstraints()
    }
    
    
    private func configureContainer() {
        backgroundColor = .black
        layer.cornerRadius = Constants.customAlertCornerRadius
        layer.borderWidth = Constants.customAlertBorderWidth
        layer.borderColor = UIColor.appWhite.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func setupSubviews() {
        addSubview(messageLabel)
        addSubview(okButton)
        
        if !isSuccessAlert {
            guard let cancelButton else { return }
            addSubview(cancelButton)
        } 
    }
    
    
    private func configureMessageLabel() {
        messageLabel.text = messageText
        messageLabel.textColor = .appWhite
        messageLabel.font = UIFont(name: TextValues.helveticaNeue, size: Constants.alertContainerMessageLabelSize)
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func configureOkButton() {
        okButton.addTarget(self, action: #selector(okButtonAction), for: .touchUpInside)
    }
    
    
    @objc private func okButtonAction() {
        vm?.okButtonAction(alertVC: alertVC)
    }
    
    
    private func configureCancelButton() {
        if !isSuccessAlert {
            cancelButton = CustomButton(text: TextValues.cancel, color: .appYellow)
            cancelButton?.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
        }
    }
    
    
    @objc private func cancelButtonAction() {
        vm?.cancelButtonAction(alertVC: alertVC)
    }
    
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.alertContainerMessageLabelPadding),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.alertContainerMessageLabelPadding),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.alertContainerMessageLabelPadding),
            
            
            okButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.alertContainerMessageLabelPadding)
        ])
        
        if isSuccessAlert {
            NSLayoutConstraint.activate([
                okButton.centerXAnchor.constraint(equalTo: centerXAnchor),
                
            ])
        } else {
            guard let cancelButton else { return }
            NSLayoutConstraint.activate([
                cancelButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.alertContainerCancelButtonLeadingAnchor),
                cancelButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.alertContainerMessageLabelPadding),
                
                okButton.leadingAnchor.constraint(equalTo: cancelButton.trailingAnchor, constant: Constants.alertContainerOkButtonLeadingAnchor)
            ])
        }
    }
}
