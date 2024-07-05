//
//  CustomButton.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 03.07.2024.
//

import UIKit

final class CustomButton: UIButton {
    
    private var text: String?
    private var color: UIColor?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    init(text: String, color: UIColor) {
        super.init(frame: .zero)
        self.text = text
        self.color = color
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        titleLabel?.font = UIFont(name: TextValues.buttonLabelFont, size: Constants.buttonLabelSize)
        setTitle(text, for: .normal)
        setTitleColor(color, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
