//
//  CustomRoundedRectangleButton.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 03.07.2024.
//

import UIKit

final class CustomRoundedRectangleButton: UIButton {
    private var buttonBackgroundColor: UIColor?
    private var buttonText: String?
    private var textColor: UIColor?
    private var height: CGFloat = Constants.customRoundedRectangleButtonHeight
    private var width: CGFloat = Constants.customRoundedRectangleButtonWidth
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    init(buttonBackgroundColor: UIColor, buttonText: String, textColor: UIColor, height: CGFloat, width: CGFloat) {
        super.init(frame: .zero)
        self.buttonBackgroundColor = buttonBackgroundColor
        self.buttonText = buttonText
        self.textColor = textColor
        self.height = height
        self.width = width
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    
    private func configure() {
        setupSubviews()
        setupLayoutConstraints()
    }
    
    
    private func setupSubviews() {
        backgroundColor = buttonBackgroundColor
        setTitleColor(textColor, for: .normal)
        titleLabel?.font = UIFont(name: TextValues.customRoundedRectangleButtonLabelFont, size: Constants.buttonLabelSize)
        setTitle(buttonText, for: .normal)
        layer.cornerRadius = Constants.customRoundedRectangleButtonCornerRadius
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: width),
            heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
}

