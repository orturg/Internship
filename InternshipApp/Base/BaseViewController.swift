//
//  BaseViewController.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 29.06.2024.
//

import UIKit

class BaseViewController: UIViewController {
    let backgroundImageView = UIImageView(image: .background)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupLayoutConstraints()
    }
    
    
    private func configure() {
        backgroundImageView.alpha = 0.2
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(backgroundImageView)
    }
    
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
