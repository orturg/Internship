//
//  CustomRadioButton.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 03.07.2024.
//

import UIKit

final class CustomRadioButton: UIButton {
    private var color: UIColor?
    private var isActive = false
    private var circle = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        setupViews()
        setupLayoutConstraints()
    }
    
    
    private func setupViews() {
        layer.cornerRadius = Constants.customRadioButtonCornerRadius
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderColor = color?.cgColor
        layer.borderWidth = Constants.customRadioButtonBorderWidth
        addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        if isActive { createInnerCircle() }
    }
    
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: Constants.customRadioButtonWidth),
            heightAnchor.constraint(equalToConstant: Constants.customRadioButtonHeight)
        ])
    }
    
    
    @objc private func buttonAction() {
        isActive.toggle()
        if isActive {
            createInnerCircle()
        } else {
            circle.removeFromSuperview()
        }
    }
    
    
    private func createInnerCircle() {
        addSubview(circle)
        circle.layer.cornerRadius = Constants.customRadioButtonInnerCircleCornerRadius
        circle.layer.borderWidth = Constants.customRadioButtonInnerCircleBorderWidth
        circle.layer.borderColor = color?.cgColor
        circle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            circle.widthAnchor.constraint(equalToConstant: Constants.customRadioButtonInnerCircleWidth),
            circle.heightAnchor.constraint(equalToConstant: Constants.customRadioButtonInnerCircleHeight),
            circle.centerXAnchor.constraint(equalTo: centerXAnchor),
            circle.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
