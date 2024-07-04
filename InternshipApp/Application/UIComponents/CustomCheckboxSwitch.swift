//
//  CustomCheckboxSwitch.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 03.07.2024.
//

import UIKit


class CustomCheckboxSwitch: UIButton {
    private  var color: UIColor?
    private var isActive: Bool = false
    private let checkmarkImageView = UIImageView(image: UIImage(named: "checkmark"))
    
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
        layer.cornerRadius = 3
        layer.borderWidth = 3
        layer.borderColor = color?.cgColor
        translatesAutoresizingMaskIntoConstraints = false
        
        widthAnchor.constraint(equalToConstant: 16).isActive = true
        heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        addTarget(self, action: #selector(checkboxAction), for: .touchUpInside)
        
        backgroundColor = isActive ? color : .clear
        if isActive { addCheckmarkImageView() }
    }
    
    @objc func checkboxAction() {
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
        
        checkmarkImageView.widthAnchor.constraint(equalToConstant: 8).isActive = true
        checkmarkImageView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        checkmarkImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        checkmarkImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}

