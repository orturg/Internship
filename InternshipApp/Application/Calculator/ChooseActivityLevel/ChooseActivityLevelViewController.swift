//
//  ChooseActivityLevelViewController.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 15.08.2024.
//

import UIKit

class ChooseActivityLevelViewController: UIViewController {

    var vm: ChooseActivityLevelViewModel?
        
    lazy var containerView = {
        let containerView = ChooseActivityLevelContainer(vc: self)
        containerView.vm = vm
        return containerView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    
    private func configure() {
        configureVC()
        setupTapGesture()
        setupSubviews()
        setupLayoutConstraints()
    }
    
    
    private func configureVC() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
    }
    
    
    private func setupSubviews() {
        view.addSubview(containerView)
    }
    
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutside))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    
    @objc private func handleTapOutside(sender: UITapGestureRecognizer) {
        let location = sender.location(in: view)
        if !containerView.frame.contains(location) {
            dismiss(animated: true)
        }
    }
    
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.chooseActivityLevelVCContainerVerticalAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.chooseActivityLevelVCContainerHorizontalAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.chooseActivityLevelVCContainerHorizontalAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.chooseActivityLevelVCContainerVerticalAnchor),
        ])
    }

}
