//
//  ChooseActivityLevelCell.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 15.08.2024.
//

import UIKit

class ChooseActivityLevelCell: UITableViewCell {
    
    static let reuseID = TextValues.chooseActivityLevelCellReuseID
    private let radioButton = CustomRadioButton(color: .appWhite)
    private let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        configureCell()
        configureTitleLabel()
        setupSubviews()
        setupLayoutSubviews()
    }
    
    
    private func configureCell() {
        backgroundColor = .clear
    }
    
    
    private func setupSubviews() {
        contentView.addSubview(radioButton)
        contentView.addSubview(titleLabel)
    }
    
    
    private func configureTitleLabel() {
        titleLabel.font = UIFont(name: TextValues.helveticaNeue, size: Constants.chooseActivityLevelCellTitleLabelSize)
        titleLabel.textColor = .appWhite
        titleLabel.numberOfLines = 2
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func setTitle(_ text: String) {
        titleLabel.text = text
    }
    
    
    func setButton(_ status: Bool) {
        radioButton.setStatus(status)
    }
    
    
    private func setupLayoutSubviews() {
        NSLayoutConstraint.activate([
            radioButton.topAnchor.constraint(equalTo: topAnchor, constant: Constants.chooseActivityLevelCellRadioButtonTopAnchor),
            radioButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: radioButton.trailingAnchor, constant: Constants.chooseActivityLevelCellTitleLabelLeadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.chooseActivityLevelCellTitleLabelTrailingAnchor)
        ])
    }
}
