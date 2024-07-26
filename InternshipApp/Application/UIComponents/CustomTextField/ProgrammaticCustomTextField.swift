//
//  ProgrammaticCustomTextField.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 25.07.2024.
//

import UIKit

import UIKit

final class ProgrammaticCustomTextField: UIView {
    var textField: UITextField = UITextField()
    var titleLabel: UILabel = UILabel()
    var placeholderText: String?

    
    init() {
        super.init(frame: .zero)
        configure()

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    
    private func configure() {
        configureLabel()
        configureTextField()
        setupSubviews()
        setupLayoutConstraints()
    }
    
    
    private func configureLabel() {
        titleLabel.textColor = UIColor.appWhite
        titleLabel.font = UIFont(name: TextValues.helveticaNeue, size: Constants.programmaticCustomTextFieldTitleLabelSize)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func configureTextField() {
        textField.textColor = .appWhite
        textField.layer.borderWidth = Constants.textFieldBorderWidth
        textField.layer.cornerRadius = Constants.textFieldCornerRadius
        textField.layer.borderColor = UIColor.appSecondary.cgColor
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: Constants.textFieldPaddingWidth, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func setSecureField() {
        textField.isSecureTextEntry = true
    }
    
    
    func setTextFieldTitle(text: String) {
        titleLabel.text = text
    }
    
    
    func setTextFieldPlaceholder(text: String) {
        textField.attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.appSecondary]
        )
        self.placeholderText = text
    }
    
    
    func getText() -> String {
        return textField.text ?? " "
    }
    
    
    func changeToRed() {
        titleLabel.textColor = .appRed
        textField.layer.borderColor = UIColor.appRed.cgColor
        textField.textColor = UIColor.appRed
    }
    
    
    func setTextFieldText(text: String) {
        textField.text = text
    }
    
    
    private func setupSubviews() {
        addSubview(titleLabel)
        addSubview(textField)
    }
    
    
    private func setupLayoutConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: topAnchor),
            heightAnchor.constraint(equalToConstant: Constants.programmaticCustomTextFieldHeight),
            leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.programmaticCustomTextFieldTitleLabelHeight),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: Constants.programmaticCustomTextFieldTitleTextFieldHeight)
        ])
    }
}
