//
//  CustomButton.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 03.07.2024.
//

import UIKit

class CustomButton: UIButton {
    
    var text: String?
    var color: UIColor?

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
    
    
    func configure() {
        titleLabel?.font = UIFont(name: "Saira-Bold", size: 16)
        setTitle(text, for: .normal)
        setTitleColor(color, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
