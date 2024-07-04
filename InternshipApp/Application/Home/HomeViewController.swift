//
//  HomeViewController.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 29.06.2024.
//

import UIKit

final class HomeViewController: BaseViewController {
    
    var vm: HomeViewModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutViews()
    }
    
    init(vm: HomeViewModel? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.vm = vm
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func layoutViews() {
        let roundedRectangleButton = CustomRoundedRectangleButton(buttonBackgroundColor: .appYellow, buttonText: TextValues.addButtonLabel, textColor: .black, height: Constants.customRoundedRectangleButtonHeight, width: Constants.customRoundedRectangleButtonWidth)
        view.addSubview(roundedRectangleButton)
        
        let button = CustomButton(text: TextValues.backToLoginLabel, color: .appYellow)
        view.addSubview(button)
        
        let button2 = CustomButton(text: TextValues.deleteAccountLabel, color: .appRed)
        view.addSubview(button2)
        
        let customSwitch = CustomSwitch(color: .appYellow)
        view.addSubview(customSwitch)
        
        let customCheckBox = CustomCheckboxSwitch(color: .appYellow)
        view.addSubview(customCheckBox)
        
        let customRadioButton = CustomRadioButton(color: .appWhite)
        view.addSubview(customRadioButton)
        
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
