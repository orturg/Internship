//  SelectOptionsViewController.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 23.07.2024.
//

import UIKit

class SelectOptionsViewController: UIViewController {

    var vm: SelectOptionsViewModel?
        
    lazy var containerView = {
        let containerView = SelectOptionsContainer(vc: self)
        containerView.vm = vm
        return containerView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    
    private func configure() {
        configureVC()
        setupSubviews()
        setupLayoutConstraints()
    }
    
    
    private func configureVC() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
    }
    
    
    private func setupSubviews() {
        view.addSubview(containerView)
    }
    
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: Constants.selectOptionsContainerWidth),
            containerView.heightAnchor.constraint(equalToConstant: Constants.selectOptionsContainerHeight)
        ])
    }
}
