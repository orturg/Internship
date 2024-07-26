//
//  OptionCell.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 24.07.2024.
//

import UIKit

class OptionCell: UITableViewCell {

    static let reuseID = "OptionCell"
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
        optionLabel.font = UIFont(name: TextValues.sairaRegular, size: 18)
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
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            button.widthAnchor.constraint(equalToConstant: 16),
            button.heightAnchor.constraint(equalToConstant: 16),
            
            optionLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            optionLabel.leadingAnchor.constraint(equalTo: button.trailingAnchor, constant: 18),
            optionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            optionLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    

}
