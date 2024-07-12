//
//  CustomTextField.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 02.07.2024.
//

import UIKit

final class CustomTextField: UIView {
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var titleLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        let subview = self.loadViewFromXib()
        subview.frame = self.bounds
        subview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        configureTextField()
        
        addSubview(subview)
    }
    
    
    private func configureTextField() {
        textField.layer.borderWidth = Constants.textFieldBorderWidth
        textField.layer.cornerRadius = Constants.textFieldCornerRadius
        textField.layer.borderColor = UIColor.appSecondary.cgColor
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: Constants.textFieldPaddingWidth, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
    }
    
    
    private func loadViewFromXib() -> UIView {
        guard let view = Bundle.main.loadNibNamed(TextValues.customTextFieldText, owner: self)?.first as? UIView else {
            return UIView()
        }
        return view
    }
    
    
    @IBAction func textfieldTapped(_ sender: UITextField) {
        titleLabel.textColor = UIColor.appWhite
        textField.layer.borderColor = UIColor.appWhite.cgColor
        textField.textColor = UIColor.appWhite
    }
    
    
    func setSecureField() {
        textField.isSecureTextEntry = true
    }
    
    
    func setTextFieldTitle(text: String) {
        titleLabel.text = text
    }
    
    
    func setTextFieldPlaceholder(text: String) {
        textField.placeholder = text
    }
    
    
    func getText() -> String {
        return textField.text ?? " "
    }
    
    
    func changeToRed() {
        titleLabel.textColor = .appRed
        textField.layer.borderColor = UIColor.appRed.cgColor
        textField.textColor = UIColor.appRed
    }
}
