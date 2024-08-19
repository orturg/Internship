//
//  CalculationViewStack.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 16.08.2024.
//

import UIKit

final class CalculationViewStack: UIStackView {
    
    private let titleLabel = UILabel()
    let textField = UITextField()
    private let unitsLabel = UILabel()
    
    private var titleLabelText: String
    
    init(titleLabelText: String) {
        self.titleLabelText = titleLabelText
        super.init(frame: .zero)
        configure()
    }
    
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        configureStack()
        configureStack()
        configureTitleLabel()
        configureTextField()
        configureUnitsLabel()
        setupSubviews()
        setupLayoutConstraints()
    }
    
    
    
    
    private func configureStack() {
        axis = .horizontal
        spacing = 8
    }
    
    
    private func setupSubviews() {
        addArrangedSubview(titleLabel)
        addArrangedSubview(textField)
        addArrangedSubview(unitsLabel)
    }
    
    
    private func configureTitleLabel() {
        titleLabel.text = titleLabelText
        titleLabel.font = UIFont(name: TextValues.helveticaNeue, size: Constants.calculationViewStackTitleLabelSize)
        titleLabel.textColor = .appWhite
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func configureTextField() {
        textField.layer.borderWidth = Constants.textFieldBorderWidth
        textField.layer.cornerRadius = Constants.textFieldCornerRadius
        textField.layer.borderColor = UIColor.appSecondary.cgColor
        textField.textColor = .appWhite
        
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: Constants.textFieldPaddingWidth, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChangeValue), for: .editingChanged)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    @objc private func textFieldDidChangeValue() {
        textField.layer.borderColor = UIColor.appSecondary.cgColor
        textField.textColor = UIColor.appWhite
    }
    
    
    private func configureUnitsLabel() {
        unitsLabel.text = titleLabelText == TextValues.weight ? TextValues.kg : (titleLabelText == TextValues.age ? TextValues.years : TextValues.cm)
        unitsLabel.font = UIFont(name: TextValues.helveticaNeue, size: Constants.calculationViewStackUnitsLabelSize)
        unitsLabel.textColor = .appSecondary
        
        unitsLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func setTitleLabel(_ text: String) {
        titleLabel.text = text
    }
    
    
    func setUnitsLabel(_ text: String) {
        unitsLabel.text = text
    }
    
    
    func getText() -> String {
        textField.text ?? ""
    }
    
    
    func makeTextFieldRed() {
        textField.layer.borderColor = UIColor.appRed.cgColor
        textField.textColor = UIColor.appRed
    }
    
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.calculationViewStackTextFieldLeadingAnchor),
            textField.widthAnchor.constraint(equalToConstant: Constants.calculationViewStackTextFieldTrailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: Constants.calculationViewStackTextFieldHeightAnchor),
            
            unitsLabel.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            unitsLabel.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: Constants.calculationViewStackUnitsLabelLeadingAnchor),
        ])
    }
}


extension CalculationViewStack: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.appSecondary.cgColor
        textField.textColor = UIColor.appWhite
    }
}

