//
//  HomeCell.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 27.07.2024.
//

import Foundation

import UIKit

class HomeCell: UICollectionViewCell {
    static let reuseID = TextValues.homeReuseID
    
    private var titleLabel = UILabel()
    private var quantityLabel = UILabel()
    private var metricLabel = UILabel()
    private var circle = UIView()
    private var differenceLabel = UILabel()
    
    
    func configure() {
        configureCell()
        configureTitleLabel()
        configureQuantityLabel()
        configureMetricLabel()
        configureCircle()
        configureDifferenceLabel()
        setupSubviews()
        setupLayoutConstraints()
    }
    
    
    private func configureCell() {
        layer.cornerRadius = Constants.homeCollectionViewCellCornerRadius
        layer.borderWidth = Constants.homeCollectionViewCellBorderWidth
        layer.borderColor = UIColor.appWhite.cgColor
    }
    
    
    private func configureTitleLabel() {
        titleLabel.textColor = .appWhite
        titleLabel.font = UIFont(name: TextValues.helveticaNeue, size: Constants.homeCollectionViewCellTitleSize)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func setTitleLabel(_ text: String) {
        titleLabel.text = text
    }
    
    
    private func configureQuantityLabel() {
        quantityLabel.textColor = .appYellow
        quantityLabel.font = UIFont.systemFont(ofSize: Constants.homeCollectionViewCellQuantitySize, weight: .bold)
        
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func setQuantityLabel(_ value: String) {
        quantityLabel.text = value
    }
    
    
    private func configureMetricLabel() {
        metricLabel.textColor = .appWhite
        metricLabel.font = UIFont(name: TextValues.helveticaNeue, size: Constants.homeCollectionViewCellMetricSize)
        
        metricLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func setMetricLabel(_ text: String) {
        metricLabel.text = text
    }
    
    
    private func configureCircle() {
        circle.layer.cornerRadius = Constants.homeCollectionViewCellCircleCornerRadius
        
        circle.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func setCircle(_ color: UIColor) {
        circle.backgroundColor = color
    }
    
    
    private func configureDifferenceLabel() {
        differenceLabel.textColor = .appWhite
        differenceLabel.font = UIFont(name: TextValues.sairaBold, size: Constants.homeCollectionViewCellDifferenceLabelSize)
        
        differenceLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func setDifferenceLabel(_ text: String) {
        differenceLabel.text = text
    }
    
    
    private func setupSubviews() {
        addSubview(titleLabel)
        addSubview(quantityLabel)
        addSubview(metricLabel)
        addSubview(circle)
        addSubview(differenceLabel)
    }
    
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.homeCollectionViewCellTitleLabelTopAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.homeCollectionViewCellTitleLabelLeadingAnchor),
            
            quantityLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.homeCollectionViewCellQuantityLabelTopAnchor),
            quantityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.homeCollectionViewCellQuantityLabelLeadingAnchor),
            
            metricLabel.leadingAnchor.constraint(equalTo: quantityLabel.trailingAnchor, constant: Constants.homeCollectionViewCellMetricLabelLeadingAnchor),
            metricLabel.bottomAnchor.constraint(equalTo: quantityLabel.bottomAnchor, constant: -Constants.homeCollectionViewCellMetricLabelBottomAnchor),
            
            circle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.homeCollectionViewCellCircleTrailingAnchor),
            circle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.homeCollectionViewCellCircleBottomAnchor),
            circle.widthAnchor.constraint(equalToConstant: Constants.homeCollectionViewCellCircleWidthAnchor),
            circle.heightAnchor.constraint(equalToConstant: Constants.homeCollectionViewCellCircleHeightAnchor),
            
            differenceLabel.centerXAnchor.constraint(equalTo: circle.centerXAnchor),
            differenceLabel.centerYAnchor.constraint(equalTo: circle.centerYAnchor)
        ])
    }
}
