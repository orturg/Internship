//
//  SelectOptionsContainer.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 23.07.2024.
//

import UIKit

class SelectOptionsContainer: UIView {
    
    var vm: SelectOptionsViewModel?
    
    var vc: UIViewController
    
    let title = UILabel()
    let cancelButton = CustomButton(text: TextValues.cancel, color: .appWhite)
    let selectButton = CustomButton(text: TextValues.select, color: .appYellow)
    
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
        configureCancelButton()
        configureSelectButton()
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
    
    
    private func configureTitle() {
        title.text = TextValues.selectOption
        title.font = UIFont(name: TextValues.sairaMedium, size: Constants.selectOptionsContainerTitleSize)
        title.textColor = .appYellow
        title.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func configureTableView() {
        tableView.frame = bounds
        tableView.rowHeight = Constants.selectOptionsCellHeight
        tableView.backgroundColor = .black
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(OptionCell.self, forCellReuseIdentifier: OptionCell.reuseID)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        vm?.tableView = tableView
    }
    
    
    private func configureCancelButton() {
        cancelButton.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
    }
    
    
    @objc private func cancelButtonAction() {
        vm?.cancelButtonAction(vc: vc)
    }
    
    
    private func configureSelectButton() {
        selectButton.addTarget(self, action: #selector(selectButtonAction), for: .touchUpInside)
    }
    
    
    @objc private func selectButtonAction() {
        vm?.selectButtonAction(vc: vc)
    }
    
    
    private func setupSubviews() {
        addSubview(title)
        addSubview(tableView)
        addSubview(cancelButton)
        addSubview(selectButton)
    }
    
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: Constants.selectOptionsContainerTopAnchor),
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            title.widthAnchor.constraint(equalToConstant: Constants.selectOptionsContainerTitleWidth),
            title.heightAnchor.constraint(equalToConstant: Constants.selectOptionsContainerTitleHeight),
            
            tableView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: Constants.selectOptionsTableViewPadding),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.selectOptionsTableViewPadding),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.selectOptionsTableViewPadding),
            tableView.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -Constants.selectOptionsTableViewPadding),
            
            cancelButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.selectOptionsContainerCancelButtonLeadingAnchor),
            cancelButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.selectOptionsContainerButtonBottomAnchor),
            cancelButton.widthAnchor.constraint(equalToConstant: Constants.selectOptionsContainerButtonWidth),
            cancelButton.heightAnchor.constraint(equalToConstant: Constants.selectOptionsContainerButtonHeight),
            
            selectButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.selectOptionsContainerSelectButtonTrailingAnchor),
            selectButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.selectOptionsContainerButtonBottomAnchor),
            selectButton.widthAnchor.constraint(equalToConstant: Constants.selectOptionsContainerButtonWidth),
            selectButton.heightAnchor.constraint(equalToConstant: Constants.selectOptionsContainerButtonHeight),
        ])
    }
}


extension SelectOptionsContainer: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? OptionCell else { return }
        cell.toggle()
    }
}

extension SelectOptionsContainer: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        OptionDataName.allCases.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OptionCell.reuseID, for: indexPath) as? OptionCell else {
            return UITableViewCell()
        }
        
        let option = OptionDataName.allCases[indexPath.row]
        cell.set(text: option.rawValue)
        
        vm?.tableView = tableView
        
        if let delegate = vm?.delegate, delegate.cells.contains(where: { $0.optionLabel.text == cell.optionLabel.text }) {
            cell.toggle()
        } else {
            cell.button.isActive = false
        }
        
        return cell
    }
}
