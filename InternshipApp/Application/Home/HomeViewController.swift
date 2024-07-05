//
//  HomeViewController.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 29.06.2024.
//

import UIKit

final class HomeViewController: BaseViewController {
    
    let roundedRectangleButton = CustomRoundedRectangleButton(buttonBackgroundColor: .appYellow, buttonText: TextValues.addButtonLabel, textColor: .black, height: Constants.customRoundedRectangleButtonHeight, width: Constants.customRoundedRectangleButtonWidth)
    let button = CustomButton(text: TextValues.backToLoginLabel, color: .appYellow)
    let button2 = CustomButton(text: TextValues.deleteAccountLabel, color: .appRed)
    let customSwitch = CustomSwitch(color: .appYellow)
    let customCheckBox = CustomCheckboxSwitch(color: .appYellow)
    let customRadioButton = CustomRadioButton(color: .appWhite)
    
    var vm: HomeViewModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    init(vm: HomeViewModel? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.vm = vm
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    private func configure() {
        setupSubviews()
        setupLayoutConstraints()
    }
    
    
    private func setupSubviews() {
        view.addSubview(roundedRectangleButton)
        view.addSubview(button)
        view.addSubview(button2)
        view.addSubview(customSwitch)
        view.addSubview(customCheckBox)
        view.addSubview(customRadioButton)
    }
    
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            roundedRectangleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            roundedRectangleButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 70),
            
            button2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button2.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100),
            
            customSwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customSwitch.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 130),
            
            customCheckBox.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customCheckBox.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 160),
            
            customRadioButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customRadioButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 180),
        ])
    }
}
