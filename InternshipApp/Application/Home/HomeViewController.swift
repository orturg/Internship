//
//  HomeViewController.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 29.06.2024.
//

import UIKit

final class HomeViewController: BaseViewController {
    var vm: HomeViewModel?
    
    lazy var titleLabel: UILabel = {
        var titleLabel = UILabel()
        titleLabel.text = vm?.titleText
        titleLabel.font = UIFont(name: TextValues.homeVCTitleLabelFont, size: Constants.homeVCTitleLabelSize)
        titleLabel.textColor = .appWhite
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    lazy var gradient: GradientView = {
        GradientView(width: Constants.gradientViewWidth, height: view.bounds.height, topColor: .clear, bottomColor: .black)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    
    private func setupSubviews() {
        view.addSubview(gradient)
        view.addSubview(titleLabel)
    }
    
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            gradient.topAnchor.constraint(equalTo: view.topAnchor),
            gradient.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradient.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gradient.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.homeTitleLabelPadding)
        ])
    }
}
