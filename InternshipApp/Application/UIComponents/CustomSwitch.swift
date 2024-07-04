//
//  CustomSwitch.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 03.07.2024.
//

import UIKit

class CustomSwitch: UISwitch {
    
    private var color: UIColor?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    init(color: UIColor) {
        super.init(frame: CGRect(x: 0, y: 0, width: 73, height: 33))
        self.color = color
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        onTintColor = color
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
