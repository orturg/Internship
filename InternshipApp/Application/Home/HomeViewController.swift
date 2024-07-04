//
//  HomeViewController.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 29.06.2024.
//

import UIKit

class HomeViewController: BaseViewController {
    
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
        let roundedRectangleButton = CustomRoundedRectangleButton(buttonBackgroundColor: .appYellow, buttonText: "Add Options", textColor: .black, height: 49, width: 289)
        
        view.addSubview(roundedRectangleButton)
        roundedRectangleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        roundedRectangleButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        let button = CustomButton(text: "Back to login", color: .appYellow)
        view.addSubview(button)
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 70).isActive = true
        
        let button2 = CustomButton(text: "Delete account", color: .appRed)
        view.addSubview(button2)
        button2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button2.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100).isActive = true
        
        let customSwitch = CustomSwitch(color: .appYellow)
        view.addSubview(customSwitch)
        customSwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        customSwitch.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 130).isActive = true
        
        let customCheckBox = CustomCheckboxSwitch(color: .appYellow)
        view.addSubview(customCheckBox)
        customCheckBox.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        customCheckBox.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 160).isActive = true
        
        let customRadioButton = CustomRadioButton(color: .appWhite)
        view.addSubview(customRadioButton)
        customRadioButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        customRadioButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 180).isActive = true
    }
}
