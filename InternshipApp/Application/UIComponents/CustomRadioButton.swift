//
//  CustomRadioButton.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 03.07.2024.
//

import UIKit

class CustomRadioButton: UIButton {
    
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
        layer.cornerRadius = 8
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderColor = color?.cgColor
        layer.borderWidth = 2
        
        widthAnchor.constraint(equalToConstant: 15).isActive = true
        heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        if isActive { createInnerCircle() }
    }
    
    
    @objc func buttonAction() {
        isActive.toggle()
        if isActive {
            createInnerCircle()
        } else {
            circle.removeFromSuperview()
        }
    }
    
    
    private func createInnerCircle() {
        addSubview(circle)
        circle.layer.cornerRadius = 3
        circle.layer.borderWidth = 5
        circle.layer.borderColor = color?.cgColor
        circle.translatesAutoresizingMaskIntoConstraints = false
        
        circle.widthAnchor.constraint(equalToConstant: 6).isActive = true
        circle.heightAnchor.constraint(equalToConstant: 6).isActive = true
        circle.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        circle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
