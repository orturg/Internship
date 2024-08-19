//  ChooseActivityLevelContainer.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 15.08.2024.
//

import UIKit

final class ChooseActivityLevelContainer: UIView {

    var vm: ChooseActivityLevelViewModel?
    var vc: UIViewController

    let titleLabel = UILabel()
    let confirmButton = CustomRoundedRectangleButton(buttonBackgroundColor: .appYellow, buttonText: TextValues.confirm, textColor: .black, height: Constants.confirmButtonHeight, width: Constants.confirmButtonWidth)
    
    let tableView = UITableView()
    
    init(vc: UIViewController) {
        self.vc = vc
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        configureContainer()
        configureTitle()
        configureTableView()
        configureConfirmButton()
        setupSubviews()
        setupLayoutConstraints()
    }
    
    private func configureContainer() {
        backgroundColor = .black
        layer.cornerRadius = Constants.customAlertCornerRadius
        layer.borderWidth = Constants.customAlertBorderWidth
        layer.borderColor = UIColor.appWhite.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupSubviews() {
        addSubview(titleLabel)
        addSubview(tableView)
        addSubview(confirmButton)
    }
    
    private func configureTitle() {
        titleLabel.text = TextValues.chooseYourActivityLevel
        titleLabel.font = UIFont(name: TextValues.sairaMedium, size: Constants.selectOptionsContainerTitleSize)
        titleLabel.textColor = .appYellow
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureTableView() {
        tableView.register(ChooseActivityLevelCell.self, forCellReuseIdentifier: ChooseActivityLevelCell.reuseID)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.rowHeight = Constants.chooseYourActivityLevelContainerTableViewRowHeight
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureConfirmButton() {
        confirmButton.addTarget(self, action: #selector(confirmButtonAction), for: .touchUpInside)
    }
    
    
    @objc private func confirmButtonAction() {
        vm?.confirmButtonAction()
        vc.dismiss(animated: true)
    }
    
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.chooseYourActivityLevelContainerTitleLabelTopAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: Constants.chooseYourActivityLevelContainerTitleLabelHeightAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.chooseYourActivityLevelContainerTableViewTopAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.chooseYourActivityLevelContainerTableViewHorizontalAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.chooseYourActivityLevelContainerTableViewHorizontalAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.chooseYourActivityLevelContainerTableViewBottomAnchor),
            
            confirmButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.chooseYourActivityLevelContainerConfirmButtonHorizontalAnchor),
            confirmButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.chooseYourActivityLevelContainerConfirmButtonHorizontalAnchor),
            confirmButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.chooseYourActivityLevelContainerConfirmButtonBottomAnchor)
        ])
    }
}

extension ChooseActivityLevelContainer: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if vm?.chooseActivityDelegate?.selectedOptionIndexPath != nil, let previousCell = tableView.cellForRow(at: vm?.chooseActivityDelegate?.selectedOptionIndexPath ?? IndexPath()) as? ChooseActivityLevelCell {
            
            previousCell.setButton(false)
            vm?.chooseActivityDelegate?.selectedOptionIndexPath = nil
        } else if vm?.selectedIndexPath != nil, let previousCell = tableView.cellForRow(at: vm?.selectedIndexPath ?? IndexPath()) as? ChooseActivityLevelCell {
            
            previousCell.setButton(false)
        }
        
        if let currentCell = tableView.cellForRow(at: indexPath) as? ChooseActivityLevelCell {
            currentCell.setButton(true)
            vm?.selectedIndexPath = indexPath
        }
    }
}

extension ChooseActivityLevelContainer: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        DailyCaloriesRateActivity.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChooseActivityLevelCell.reuseID, for: indexPath) as? ChooseActivityLevelCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        cell.setTitle(DailyCaloriesRateActivity.allCases[indexPath.row].rawValue)
        cell.setButton(indexPath == vm?.chooseActivityDelegate?.selectedOptionIndexPath)
        
        return cell
    }
}
