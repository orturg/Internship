//
//  HomeCell.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 27.07.2024.
//

import UIKit

class HomeCell: UICollectionViewCell {
    static let reuseID = "HomeCell"
    
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
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.appWhite.cgColor
    }
    
    
    private func configureTitleLabel() {
        titleLabel.textColor = .appWhite
        titleLabel.font = UIFont(name: TextValues.helveticaNeue, size: 20)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func setTitleLabel(_ text: String) {
        titleLabel.text = text
    }
    
    
    private func configureQuantityLabel() {
        quantityLabel.textColor = .appYellow
        quantityLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func setQuantityLabel(_ value: Int) {
        quantityLabel.text = String(value)
    }
    
    
    private func configureMetricLabel() {
        metricLabel.textColor = .appWhite
        metricLabel.font = UIFont(name: TextValues.helveticaNeue, size: 20)
        
        metricLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func setMetricLabel(_ text: String) {
        metricLabel.text = text
    }
    
    
    private func configureCircle() {
        circle.layer.cornerRadius = 23
        
        circle.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func setCircle(_ color: UIColor) {
        circle.backgroundColor = color
    }
    
    
    private func configureDifferenceLabel() {
        differenceLabel.textColor = .appWhite
        differenceLabel.font = UIFont(name: TextValues.sairaBold, size: 19)
        
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
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            
            quantityLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            quantityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 36),
            
            metricLabel.leadingAnchor.constraint(equalTo: quantityLabel.trailingAnchor, constant: 10),
            metricLabel.bottomAnchor.constraint(equalTo: quantityLabel.bottomAnchor, constant: -5),
            
            circle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            circle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13),
            circle.widthAnchor.constraint(equalToConstant: 45),
            circle.heightAnchor.constraint(equalToConstant: 45),
            
            differenceLabel.centerXAnchor.constraint(equalTo: circle.centerXAnchor),
            differenceLabel.centerYAnchor.constraint(equalTo: circle.centerYAnchor)
        ])
    }
}
