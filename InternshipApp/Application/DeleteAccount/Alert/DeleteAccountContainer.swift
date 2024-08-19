//
//  DeleteAccountContainer.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 02.08.2024.
//

import UIKit

final class DeleteAccountContainer: UIView {
    var vm: DeleteAccountAlertViewModel?
    
    var deleteButton = CustomRoundedRectangleButton(buttonBackgroundColor: .appYellow, buttonText: TextValues.delete, textColor: .black, height: Constants.customRoundedRectangleButtonHeight, width: Constants.customAlertRoundedRectangleButtonWidth)
    
    private var cancelButton = CustomButton(text: TextValues.cancel, color: .appYellow)
    private var messageText: String
    private var messageLabel = UILabel()
    
    init(messageText: String) {
        self.messageText = messageText
        super.init(frame: .zero)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        configureContainer()
        configureMessageLabel()
        configureDeleteButton()
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
        addSubview(deleteButton)
        addSubview(cancelButton)
    }
    
    
    private func configureMessageLabel() {
        messageLabel.text = messageText
        messageLabel.textColor = .appWhite
        messageLabel.font = UIFont(name: TextValues.helveticaNeue, size: Constants.alertContainerMessageLabelSize)
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .left
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func configureDeleteButton() {
        deleteButton.addTarget(self, action: #selector(deleteButtonAction), for: .touchUpInside)
    }
    
    
    @objc private func deleteButtonAction() {
        vm?.deleteButtonAction()
    }
    
    
    private func configureCancelButton() {
        cancelButton.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
    }
    
    
    @objc private func cancelButtonAction() {
        vm?.cancelButtonAction()
    }
    
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.alertContainerMessageLabelPadding),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.alertContainerMessageLabelPadding),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.alertContainerMessageLabelPadding),
            
            cancelButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.alertContainerCancelButtonLeadingAnchor),
            cancelButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.alertContainerMessageLabelPadding),
            
            deleteButton.leadingAnchor.constraint(equalTo: cancelButton.trailingAnchor, constant: Constants.alertContainerOkButtonLeadingAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.alertContainerMessageLabelPadding)
        ])
    }
}
