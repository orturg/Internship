//
//  StartViewController.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 06.07.2024.
//

import UIKit

class StartViewController: UIViewController {
    var vm: StartViewModel?
    
    @IBOutlet weak var titleLabels: UILabel!
    @IBOutlet weak var gradientDivider: GradientDivider!
    @IBOutlet weak var backgroundImages: UIImageView!
    var superManButton = CustomRoundedRectangleButton(buttonBackgroundColor: .appYellow, buttonText: TextValues.superManLabel, textColor: .black, height: Constants.startScreenButtonHeight, width: Constants.startScreenButtonWidth)
    var superGirlButton = CustomRoundedRectangleButton(buttonBackgroundColor: .appYellow, buttonText: TextValues.superGirlLabel, textColor: .black, height: Constants.startScreenButtonHeight, width: Constants.startScreenButtonWidth)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
    private func configure() {
        layoutSubviews()
        configureLayoutConstraints()
    }
    
    
    private func layoutSubviews() {
        view.addSubview(superManButton)
        view.addSubview(superGirlButton)
        
        superManButton.addTarget(self, action: #selector(superManButtonAction), for: .touchUpInside)
        superGirlButton.addTarget(self, action: #selector(superGirlButtonAction), for: .touchUpInside)
    }
    
    
    @objc private func superManButtonAction() {
        guard let navigationController else { return }
        
        let tabBarCoordinator = TabBarCoordinator(navigationController: navigationController, titleText: TextValues.superManLabel, isMan: true)
        tabBarCoordinator.start()
    }
    
    
    @objc private func superGirlButtonAction() {
        guard let navigationController else { return }
        
        let tabBarCoordinator = TabBarCoordinator(navigationController: navigationController, titleText: TextValues.superGirlLabel, isMan: false)
        tabBarCoordinator.start()
    }
    
    
    private func configureLayoutConstraints() {
        NSLayoutConstraint.activate([
            superManButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            superManButton.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.startViewControllerButtonPadding),
            
            superGirlButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            superGirlButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.startViewControllerButtonPadding),
        ])
    }
}
