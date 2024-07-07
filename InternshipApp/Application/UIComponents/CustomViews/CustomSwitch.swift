//
//  CustomSwitch.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 03.07.2024.
//

import UIKit

final class CustomSwitch: UISwitch {
    private var color: UIColor?

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
        onTintColor = color
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
