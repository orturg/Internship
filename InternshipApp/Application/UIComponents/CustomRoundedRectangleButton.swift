//
//  CustomRoundedRectangleButton.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 03.07.2024.
//

import UIKit

import UIKit

class CustomRoundedRectangleButton: UIButton {
    private var buttonBackgroundColor: UIColor?
    private var buttonText: String?
    private var textColor: UIColor?
    private var height: CGFloat = 49
    private var width: CGFloat = 289
    
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
        backgroundColor = buttonBackgroundColor
        setTitleColor(textColor, for: .normal)
        titleLabel?.font = UIFont(name: "Saira-Regular", size: 16)
        setTitle(buttonText, for: .normal)
        layer.cornerRadius = 24
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }

}

