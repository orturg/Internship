//
//  HomeViewController.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 29.06.2024.
//

import UIKit

final class HomeViewController: BaseViewController {
    var vm: HomeViewModel?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    lazy var gradient: GradientView = {
        GradientView(width: Constants.gradientViewWidth, height: view.bounds.height, topColor: .clear, bottomColor: .black)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vm?.getUser(vc: self)
        configure()
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
        setupSubviews()
        setupLayoutConstraints()
    }
    
    
    private func configureVC() {
        let backBarButtonItem = UIBarButtonItem(customView: UIView())
        navigationItem.leftBarButtonItem = backBarButtonItem
        guard let vm else { return }
        if !vm.isMan {
            super.removeBackground()
            super.setGirlBackgroundImage()
        }
    }
    
    
    func configureLabels() {
        titleLabel.text = vm?.titleText
        nameLabel.text = vm?.user?.userName
    }
    
    
    private func setupSubviews() {
        view.addSubview(gradient)
        view.addSubview(titleLabel)
        view.addSubview(nameLabel)
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
