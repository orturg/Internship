//
//  SelectOptionsContainer.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 23.07.2024.
//

import UIKit

class SelectOptionsContainer: UIView {
    
    var vm: SelectOptionsViewModel?
    
    private func configure() {
        configureContainer()
        setupSubviews()
        setupLayoutConstraints()
    }
    
    
    private func configureContainer() {
        backgroundColor = .black
        layer.cornerRadius = Constants.customAlertCornerRadius
        layer.borderWidth = Constants.customAlertBorderWidth
        layer.borderColor = UIColor.appWhite.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func setupSubviews() {
        
    }

    
    private func setupLayoutConstraints() {
        
    }
}
