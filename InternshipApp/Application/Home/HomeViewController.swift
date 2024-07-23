//
//  HomeViewController.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 29.06.2024.
//

import UIKit

final class HomeViewController: BaseViewController {
    var vm: HomeViewModel?
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var avatarImageView: UIImageView!
    
    lazy var gradient: GradientView = {
        GradientView(width: Constants.gradientViewWidth, height: view.bounds.height, topColor: .clear, bottomColor: .black)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vm?.getUser(vc: self)
        configure()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        vm?.getUser(vc: self)
        configureLabels()
    }
    
    
    init(vm: HomeViewModel? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.vm = vm
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    private func configure() {
        configureVC()
        configureLabels()
        configureAvatarImageView()
        setupSubviews()
        setupLayoutConstraints()
    }
    
    
    private func configureVC() {
        guard let vm else { return }
        if !vm.isMan {
            super.removeBackground()
            super.setGirlBackgroundImage()
        }
    }
    
    
    func configureLabels() {
        vm?.configureLabels(titleLabel: titleLabel, nameLabel: nameLabel)
    }
    
    
    private func setupSubviews() {
        view.addSubview(gradient)
        view.addSubview(titleLabel)
        view.addSubview(nameLabel)
        view.addSubview(avatarImageView)
    }
    
    
    private func configureAvatarImageView() {
        avatarImageView.layer.cornerRadius = Constants.homeAvatarImageViewCornerRadius
        avatarImageView.layer.borderWidth = Constants.homeAvatarImageViewBorderWidth
        avatarImageView.layer.borderColor = UIColor.appYellow.cgColor
        avatarImageView.image = UIImage.maleAvatarPlaceholder
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.isUserInteractionEnabled = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(avatarImageViewAction))
        avatarImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    
    func set(_ image: UIImage) {
        avatarImageView.image = image
    }
    
    
    @objc private func avatarImageViewAction() {
        vm?.avatarImageViewAction(navigationController: navigationController)
    }
    
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            gradient.topAnchor.constraint(equalTo: view.topAnchor),
            gradient.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradient.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gradient.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
