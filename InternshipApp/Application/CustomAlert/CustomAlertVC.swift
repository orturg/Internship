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
    private var withButtons: Bool
    private var containerHeight: CGFloat
    
    lazy var containerView = {
        let containerView = ContainerView(messageText: messageText, isSuccessAlert: isSuccessAlert, alertVC: self, withButtons: withButtons)
        containerView.vm = vm
        return containerView
    }()
    
    weak var delegate: ResetPasswordVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    
    init(isSuccessAlert: Bool, messageText: String, withButtons: Bool, containerHeight: CGFloat) {
        self.isSuccessAlert = isSuccessAlert
        self.messageText = messageText
        self.withButtons = withButtons
        self.containerHeight = containerHeight
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
    
    
    func dimissVC() {
        delegate?.dismissVC()
    }
    
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: Constants.alertContainerViewWidth),
            containerView.heightAnchor.constraint(equalToConstant: containerHeight)
        ])
    }
    
    
    func setImageView(image: UIImage) {
        containerView.imageView = UIImageView(image: image)
    }
}



