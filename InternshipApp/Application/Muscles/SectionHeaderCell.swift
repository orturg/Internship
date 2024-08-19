//
//  SectionHeaderCell.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 06.08.2024.
//

import UIKit

class SectionHeaderCell: UITableViewHeaderFooterView {
    
    static let reuseID = TextValues.musclesTableViewSectionHeaderCellReuseID
    let arrowImageView = UIImageView()
    let titleLabel = UILabel()
    let line = UIView()
    let selectedCellsLabel = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        configureCell()
        configureImageView()
        configureTitleLabel()
        configureLine()
        setupSubviews()
        setupLayoutConstraints()
    }
    
    
    private func setupSubviews() {
        addSubview(arrowImageView)
        addSubview(titleLabel)
        addSubview(line)
    }
    
    private func configureCell() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        backgroundView = UIView(frame: bounds)
        backgroundView?.backgroundColor = .clear
    }
    
    
    private func configureImageView() {
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
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
    
    
    func setImage(isArrowDown: Bool) {
        arrowImageView.image = isArrowDown ? UIImage.arrowDown : UIImage.arrowUp
    }
    
    
    func setTitle(_ text: String) {
        titleLabel.text = text
    }
    
    
    func setSelectedCells(amount: Int) {
        guard amount != 0 else { 
            selectedCellsLabel.removeFromSuperview()
            return
        }
        
        selectedCellsLabel.text = String(amount)
        selectedCellsLabel.textColor = .appWhite
        selectedCellsLabel.font = UIFont(name: TextValues.helveticaNeue, size: Constants.musclesTableViewSectionHeaderCellAmountLabelSize)
        
        selectedCellsLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(selectedCellsLabel)
        
        NSLayoutConstraint.activate([
            selectedCellsLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            selectedCellsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.musclesTableViewSectionHeaderCellAmountLabelTrailingAnchor)
        ])
    }
    
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            arrowImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            arrowImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor, constant: Constants.musclesTableViewSectionHeaderCellArrowCenterConstant),
            arrowImageView.widthAnchor.constraint(equalToConstant: Constants.musclesTableViewSectionHeaderCellArrowWidth),
            arrowImageView.heightAnchor.constraint(equalToConstant: Constants.musclesTableViewSectionHeaderCellArrowHeight),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: arrowImageView.trailingAnchor, constant: Constants.musclesTableViewSectionHeaderCellTitleLeadingAnchor),
            
            line.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.musclesTableViewSectionHeaderCellLineTopAnchor),
            line.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            line.trailingAnchor.constraint(equalTo: trailingAnchor),
            line.heightAnchor.constraint(equalToConstant: Constants.musclesTableViewSectionHeaderCellLineHeight),
            line.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.musclesTableViewSectionHeaderCellLineBottomAnchor)
        ])
    }
}
