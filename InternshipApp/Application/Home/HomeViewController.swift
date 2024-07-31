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
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let vm else { return }
        tabBarController?.tabBar.isHidden = false
        vm.getUser(vc: self)
        vm.getCells { [weak self] in
            guard let self else { return }
            self.configure()
            self.configureLabels()
            if vm.needToReload {
                self.collectionView.reloadData()
                vm.needToReload = false
            }
        }
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
    
    
    private func configureCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    private func setupSubviews() {
        view.addSubview(gradient)
        view.addSubview(titleLabel)
        view.addSubview(nameLabel)
        view.addSubview(avatarImageView)
        view.addSubview(collectionView)
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
            
            collectionView.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.homeCollectionViewHorizontalAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.homeCollectionViewHorizontalAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.homeCollectionViewBottomAnchor)
        ])
    }
}


extension HomeViewController: UICollectionViewDelegate {
    
}


extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        vm?.optionData.filter { $0.isShown }.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.reuseID, for: indexPath) as? HomeCell else {
            return UICollectionViewCell()
        }
        
        cell.configure()
        
        var homeCellData = vm?.optionData[indexPath.row]
        
        cell.setTitleLabel(homeCellData?.optionName.rawValue ?? "")
        cell.setQuantityLabel(String(homeCellData?.valueArray.last ?? 0))
        cell.setMetricLabel(homeCellData?.optionName.rawValue == TextValues.weight ? TextValues.kg : TextValues.cm)
        if homeCellData?.changedValue != 0 {
            cell.setCircle(homeCellData?.changedValue ?? 0 < 0 ? .systemGreen : .appRed)
            cell.setDifferenceLabel(homeCellData?.changedValue ?? 0 > 0 ? "+\( homeCellData?.changedValue ?? 0)" : String(homeCellData?.changedValue ?? 0))
        }
        
        return cell
    }
}


extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: Constants.homeCollectionViewCellWidth, height: Constants.homeCollectionViewCellHeight)
    }
}
