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
        let roundedRectangleButton = CustomRoundedRectangleButton(buttonBackgroundColor: .yellow, buttonText: "Add Options", textColor: .black, height: 49, width: 289)
        view.addSubview(roundedRectangleButton)
        roundedRectangleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        roundedRectangleButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        let button = CustomButton(text: "Back to login", color: .yellow)
        view.addSubview(button)
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 70).isActive = true
        
        let button2 = CustomButton(text: "Delete account", color: .red)
        view.addSubview(button2)
        button2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button2.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100).isActive = true
        
    }
    
    init(vm: HomeViewModel? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.vm = vm
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
