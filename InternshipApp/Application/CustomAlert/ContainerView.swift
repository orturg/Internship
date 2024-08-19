//
//  ContainerView.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 16.07.2024.
//

import UIKit

final class ContainerView: UIView {
    
    var vm: CustomAlertViewModel?
    
    var okButton: CustomRoundedRectangleButton? = CustomRoundedRectangleButton(buttonBackgroundColor: .appYellow, buttonText: TextValues.ok, textColor: .black, height: Constants.customRoundedRectangleButtonHeight, width: Constants.customAlertRoundedRectangleButtonWidth)
    
    private var cancelButton: CustomButton? = CustomButton()
    private var messageText: String
    private var isSuccessAlert: Bool
    private var messageLabel = UILabel()
    private let alertVC: CustomAlertVC
    private var withButtons: Bool
    var imageView: UIImageView?
    
    
    init(messageText: String, isSuccessAlert: Bool, alertVC: CustomAlertVC, withButtons: Bool) {
        self.messageText = messageText
        self.isSuccessAlert = isSuccessAlert
        self.alertVC = alertVC
        self.withButtons = withButtons
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
        if let imageView {
            addSubview(imageView)
        }
        
        if withButtons {
            guard let okButton else { return }
            addSubview(okButton)
        }
        
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
        if withButtons {
            guard let okButton else { return }
            okButton.addTarget(self, action: #selector(okButtonAction), for: .touchUpInside)
        }
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
        if withButtons {
            NSLayoutConstraint.activate([
                messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.alertContainerMessageLabelPadding),
                messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.alertContainerMessageLabelPadding),
                messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.alertContainerMessageLabelPadding),
            ])
        } else {
            
            if let imageView {
                NSLayoutConstraint.activate([
                    imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
                    imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.alertContainerMessageLabelPadding),
                    imageView.widthAnchor.constraint(equalToConstant: Constants.emptyAlertSuccessImageViewWidth),
                    imageView.heightAnchor.constraint(equalToConstant: Constants.emptyAlertSuccessImageViewHeight)
                ])
                
                NSLayoutConstraint.activate([
                    messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
                    messageLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Constants.emptyAlertMessageLeadingPadding),
                    messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.alertContainerMessageLabelPadding),
                ])
            } else {
                NSLayoutConstraint.activate([
                    messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
                    messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.alertContainerMessageLabelPadding),
                    messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.alertContainerMessageLabelPadding),
                ])
            }
        }
        
        if withButtons {
            guard let okButton else { return }
            
            NSLayoutConstraint.activate([
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
}
