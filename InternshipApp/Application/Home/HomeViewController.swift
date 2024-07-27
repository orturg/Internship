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
    
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.reuseID)
        return collectionView
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
        configureCollectionView()
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
        view.addSubview(collectionView)
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
    
    
    private func configureCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.delegate = self
        collectionView.dataSource = self
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
            
            collectionView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 37),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24)
        ])
    }
}


extension HomeViewController: UICollectionViewDelegate {
    
}


extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.reuseID, for: indexPath) as? HomeCell else {
            return UICollectionViewCell()
        }
        
        cell.configure()
        
        cell.setTitleLabel("Height")
        cell.setQuantityLabel(174)
        cell.setMetricLabel("cm")
        cell.setCircle(.red)
        cell.setDifferenceLabel("+1")
        
        return cell
    }
}


extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 300, height: 100)
    }
}
