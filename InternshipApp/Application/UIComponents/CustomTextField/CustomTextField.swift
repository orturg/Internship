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
    var placeholderText: String?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        configureSubview()
        configureLabel()
        configureTextField()
        
    }
    
    
    private func configureSubview() {
        let subview = self.loadViewFromXib()
        subview.frame = self.bounds
        subview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(subview)
    }
    
    
    private func configureLabel() {
        titleLabel.textColor = UIColor.appWhite
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
    
    
    @IBAction func textfieldTapped(_ sender: UITextField) {
        titleLabel.textColor = UIColor.appWhite
        textField.layer.borderColor = UIColor.appWhite.cgColor
        textField.textColor = UIColor.appWhite
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholderText ?? "",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.appWhite]
        )
    }
    
    
    @IBAction func textFieldTextChanged(_ sender: Any) {
        if titleLabel.textColor == .appRed &&
            textField.layer.borderColor == UIColor.appRed.cgColor &&
            textField.textColor == UIColor.appRed {
            titleLabel.textColor = UIColor.appWhite
            textField.layer.borderColor = UIColor.appWhite.cgColor
            textField.textColor = UIColor.appWhite
        }
    }
    
    
    @IBAction func textfieldDidEndEditing(_ sender: Any) {
        configureLabel()
        configureTextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholderText ?? "",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.appSecondary]
        )
    }
}
