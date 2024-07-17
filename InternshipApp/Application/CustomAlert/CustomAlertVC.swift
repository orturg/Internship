//
//  CustomAlertVC.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 16.07.2024.
//

import UIKit

final class CustomAlertVC: UIViewController {
    
    var vm: CustomAlertViewModel?
    
    private var messageText: String
    private let isSuccessAlert: Bool
    private let resetPasswordVC: UIViewController
    lazy var containerView = {
        let containerView = ContainerView(messageText: messageText, isSuccessAlert: isSuccessAlert, alertVC: self, resetPasswordVC: resetPasswordVC)
        containerView.vm = vm
        return containerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    
    init(isSuccessAlert: Bool, messageText: String, resetPasswordVC: UIViewController) {
        self.isSuccessAlert = isSuccessAlert
        self.messageText = messageText
        self.resetPasswordVC = resetPasswordVC
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
        vm?.handleTapOutside(sender: sender, view: view, containerView: containerView, vc: self)
    }
    
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: Constants.alertContainerViewWidth),
            containerView.heightAnchor.constraint(equalToConstant: Constants.alertContainerViewHeight)
        ])
    }
}
