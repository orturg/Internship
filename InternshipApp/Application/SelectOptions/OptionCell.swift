//
//  OptionCell.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 24.07.2024.
//

import UIKit

class OptionCell: UITableViewCell {

    static let reuseID = TextValues.optionCellReuseID
    let button = CustomCheckboxSwitch(color: .appYellow)
    let optionLabel = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        configureCell()
        configureOptionLabel()
        setupSubviews()
        setupLayoutConstraints()
    }
    
    
    private func configureCell() {
        selectionStyle = .none
        backgroundColor = .black
    }
    
    
    private func configureOptionLabel() {
        optionLabel.font = UIFont(name: TextValues.sairaRegular, size: Constants.optionCellOptionLabelSize)
        optionLabel.textColor = .appWhite
        optionLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func set(text: String) {
        optionLabel.text = text
    }
    
    
    func setButton(isActive: Bool) {
        button.isActive = isActive
    }
    
    
    func toggle() {
        button.checkboxAction()
    }
    
    
    private func setupSubviews() {
        addSubview(button)
        addSubview(optionLabel)
    }
    
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: centerYAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.optionCellButtonLeadingAnchor),
            button.widthAnchor.constraint(equalToConstant: Constants.optionCellButtonWidth),
            button.heightAnchor.constraint(equalToConstant: Constants.optionCellButtonHeight),
            
            optionLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            optionLabel.leadingAnchor.constraint(equalTo: button.trailingAnchor, constant: Constants.optionCellOptionLabelLeadingAnchor),
            optionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            optionLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    

}
