//
//  CustomCheckboxSwitch.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 03.07.2024.
//

import UIKit


final class CustomCheckboxSwitch: UIButton {
    private  var color: UIColor?
    private var isActive: Bool = false
    private let checkmarkImageView = UIImageView(image: UIImage.checkmark)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    init(color: UIColor) {
        super.init(frame: .zero)
        self.color = color
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        setupSubviews()
        setupLayoutConstraints()
    }
    
    
    private func setupSubviews() {
        layer.cornerRadius = Constants.customCheckboxSwitchCornerRadius
        layer.borderWidth = Constants.customCheckboxSwitchBorderWidth
        layer.borderColor = color?.cgColor
        translatesAutoresizingMaskIntoConstraints = false
        addTarget(self, action: #selector(checkboxAction), for: .touchUpInside)
        backgroundColor = isActive ? color : .clear
        if isActive { addCheckmarkImageView() }
    }
    
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: Constants.customCheckboxSwitchWidth),
            heightAnchor.constraint(equalToConstant: Constants.customCheckboxSwitchHeight)
        ])
    }
    
    
    @objc private func checkboxAction() {
        isActive.toggle()
        backgroundColor = isActive ? color : .clear
        if isActive {
            addCheckmarkImageView()
        } else {
            checkmarkImageView.removeFromSuperview()
        }
    }
    
    
    private func addCheckmarkImageView() {
        addSubview(checkmarkImageView)
        checkmarkImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            checkmarkImageView.widthAnchor.constraint(equalToConstant: Constants.customCheckboxSwitchcheckmarkImageViewWidth),
            checkmarkImageView.heightAnchor.constraint(equalToConstant: Constants.customCheckboxSwitchcheckmarkImageViewHeight),
            checkmarkImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            checkmarkImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

