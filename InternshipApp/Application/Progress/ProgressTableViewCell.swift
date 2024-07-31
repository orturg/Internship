//
//  ProgressCellTableViewCell.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 30.07.2024.
//

import UIKit

class ProgressTableViewCell: UITableViewCell {
    
    static let reuseID = TextValues.progressTableViewCellReuseID
    let titleLabel = UILabel()
    let line = UIView()

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
        configureLine()
        setupSubviews()
        setupLayoutConstraints()
    }
    
    
    private func setupSubviews() {
        addSubview(titleLabel)
        addSubview(line)
    }
    
    private func configureCell() {
        backgroundColor = .clear
    }
    
    
    private func configureTitleLabel() {
        titleLabel.textColor = .appWhite
        titleLabel.font = UIFont(name: TextValues.helveticaNeue, size: Constants.progressTableViewCellTitleLabelSize)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func configureLine() {
        line.backgroundColor = .appWhite
        
        line.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func setTitle(_ text: String) {
        titleLabel.text = text
    }
    
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.progressTableViewCellTitleLabelLeadingAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            line.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.progressTableViewCellLineTopAnchor),
            line.leadingAnchor.constraint(equalTo: leadingAnchor),
            line.trailingAnchor.constraint(equalTo: trailingAnchor),
            line.heightAnchor.constraint(equalToConstant: Constants.progressTableViewCellLineHeight),
            line.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.progressTableViewCellLineBottomAnchor)
        ])
    }
}
