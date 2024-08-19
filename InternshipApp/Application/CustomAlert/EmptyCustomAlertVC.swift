//
//  EmptyCustomAlertVC.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 22.07.2024.
//

import UIKit

class EmptyCustomAlertVC: UIViewController {
    var vm: EmptyAlertViewModel?
    
    private var messageText: String
    
    lazy var containerView = {
        let containerView = EmptyContainerView(messageText: messageText)
        containerView.vm = vm
        return containerView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    
    init(messageText: String) {
        self.messageText = messageText
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: Constants.alertContainerViewWidth),
            containerView.heightAnchor.constraint(equalToConstant: Constants.emptyAlertHeight)
        ])
    }
}
