//
//  ProgressViewController.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 06.07.2024.
//

import UIKit

final class ProgressViewController: BaseViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    var vm: ProgressViewModel?
    
    var tableView = UITableView()
    var emptyStateView: EmptyStateContainer = EmptyStateContainer(text: TextValues.progressVCEmptyStateScreen, image: .alert)
    
    lazy var gradient: GradientView = {
        GradientView(width: Constants.gradientViewWidth, height: view.bounds.height, topColor: .clear, bottomColor: .black)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        vm?.getCells { [weak self] in
            guard let self else { return }
            self.configure()
        }
    }
    
    
    private func configure() {
        guard let vm else { return }
        
        view.addSubview(gradient)
        
        if vm.isOptionDataEmpty {
            tableView.removeFromSuperview()
        } else {
            emptyStateView.removeFromSuperview()
            configureTableView()
            self.tableView.reloadData()
        }
        
        setupSubviews()
        setupLayoutConstraints()
    }
    
    
    private func setupSubviews() {
        guard let vm else { return }
        
        view.addSubview(titleLabel)
        
        if vm.isOptionDataEmpty {
            view.addSubview(emptyStateView)
        } else {
            view.addSubview(tableView)
        }
    }
    
    
    private func configureTableView() {
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        
        tableView.register(ProgressTableViewCell.self, forCellReuseIdentifier: ProgressTableViewCell.reuseID)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func setupLayoutConstraints() {
        guard let vm else { return }
        
        NSLayoutConstraint.activate([
            gradient.topAnchor.constraint(equalTo: view.topAnchor),
            gradient.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradient.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gradient.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        if vm.isOptionDataEmpty {
            NSLayoutConstraint.activate([
                emptyStateView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                emptyStateView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.progressVCEmptyStateViewHorizontalAnchor),
                emptyStateView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.progressVCEmptyStateViewHorizontalAnchor),
                emptyStateView.heightAnchor.constraint(equalToConstant: Constants.progressVCEmptyStateViewHeight),
                
            ])
        } else {
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.progressVCTableViewTopAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.progressVCTableHorizontalAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.progressVCTableHorizontalAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.progressVCTableBottomAnchor)
            ])
        }
    }
}

extension ProgressViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        vm?.tapCellAction(navigationController: navigationController, optionData: vm?.optionData[indexPath.row])
    }
}


extension ProgressViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vm?.optionData.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProgressTableViewCell.reuseID, for: indexPath) as? ProgressTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.setTitle(vm?.optionData[indexPath.row].optionName.rawValue ?? "")
        
        return cell
    }
}
