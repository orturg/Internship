//
//  TextFieldCell.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 25.07.2024.
//

import UIKit

protocol TextFieldCellDelegate: AnyObject {
    func textFieldCell(_ cell: TextFieldCell, didChangeText text: String)
    func textFieldCell(_ cell: TextFieldCell, didChangeSwitchValue isOn: Bool)
}


class TextFieldCell: UITableViewCell {
    static let reuseID = TextValues.textFieldCellReuseID
    
    weak var delegate: TextFieldCellDelegate?
    
    var textField = ProgrammaticCustomTextField()
    var unitsLabel = UILabel()
    var customSwitch = CustomSwitch(color: .appYellow)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: TextFieldCell.reuseID)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        configureCell()
        configureUnitsLabel()
        configureTextField()
        configureCustomSwitch()
        setupSubviews()
        setupLayoutConstraints()
    }
    
    private func configureCell() {
        selectionStyle = .none
        backgroundColor = .black
    }
    
    private func configureTextField() {
        textField.isUserInteractionEnabled = true
        textField.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    private func configureUnitsLabel() {
        unitsLabel.textColor = .appSecondary
        unitsLabel.font = UIFont(name: TextValues.helveticaNeue, size: Constants.unitsLabelSize)
        unitsLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func configureCustomSwitch() {
        customSwitch.isUserInteractionEnabled = true
        customSwitch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
    }
    
    
    @objc private func switchValueChanged() {
        delegate?.textFieldCell(self, didChangeSwitchValue: customSwitch.isOn)
    }
    
    
    func setTextFieldTitle(text: String) {
        textField.setTextFieldTitle(text: text)
    }
    
    
    func setTextFieldText(text: String) {
        textField.textField.text = text
    }
    
    
    func setUnitsText(text: String) {
        unitsLabel.text = text
    }
    
    
    func setSwitch(isOn: Bool) {
        customSwitch.isOn = isOn
    }
    
    
    private func setupSubviews() {
        contentView.addSubview(textField)
        contentView.addSubview(unitsLabel)
        contentView.addSubview(customSwitch)
    }
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.widthAnchor.constraint(equalToConstant: Constants.textFieldBorderWidth),
            
            unitsLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            unitsLabel.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: Constants.unitsLabelLeadingAnchor),
            unitsLabel.widthAnchor.constraint(equalToConstant: Constants.unitsLabelWidth),
            unitsLabel.heightAnchor.constraint(equalToConstant: Constants.unitsLabelHeight),
            
            customSwitch.bottomAnchor.constraint(equalTo: textField.bottomAnchor),
            customSwitch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.textFieldCellCustomSwitchTrailingAnchor)
        ])
    }
    
    
    @objc private func textFieldDidChange() {
        delegate?.textFieldCell(self, didChangeText: textField.textField.text ?? "")
    }
}
