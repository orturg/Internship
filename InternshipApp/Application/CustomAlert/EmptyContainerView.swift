//
//  EmptyContainerView.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 22.07.2024.
//

import UIKit

class EmptyContainerView: UIView {
    
    var vm: EmptyAlertViewModel?
    
    private var messageText: String
    private var messageLabel = UILabel()
    private var successImageView = UIImageView()
    
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
        configureImageView()
        configureMessageLabel()
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
        addSubview(successImageView)
        addSubview(messageLabel)
    }
    
    
    private func configureMessageLabel() {
        messageLabel.text = messageText
        messageLabel.textColor = .appWhite
        messageLabel.font = UIFont(name: TextValues.helveticaNeue, size: Constants.alertContainerMessageLabelSize)
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func configureImageView() {
        successImageView.image = UIImage.success
        successImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            successImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            successImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.alertContainerMessageLabelPadding),
            successImageView.widthAnchor.constraint(equalToConstant: Constants.emptyAlertSuccessImageViewWidth),
            successImageView.heightAnchor.constraint(equalToConstant: Constants.emptyAlertSuccessImageViewHeight),
            
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: successImageView.trailingAnchor, constant: Constants.emptyAlertMessageLeadingPadding),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.alertContainerMessageLabelPadding),
        ])
    }
}
