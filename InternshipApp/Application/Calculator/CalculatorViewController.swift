//
//  CalculatorViewController.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 06.07.2024.
//

import UIKit

enum CalculatorType: String {
    case bodyMassIndex = "Body Mass Index"
    case fatPercentage = "Fat Percentage"
    case dailyCalorieRequirement = "Daily Calorie Requirement"
}

final class CalculatorViewController: BaseViewController {
    var vm: CalculatorViewModel?
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    private let tableView = UITableView()
    
    lazy var gradient: GradientView = {
        GradientView(width: Constants.gradientViewWidth, height: view.bounds.height, topColor: .clear, bottomColor: .black)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureVC()
    }
    
    
    private func configure() {
        configureVC()
        configureTableView()
        setupSubviews()
        setupLayoutConstraints()
    }
    
    
    private func configureVC() {
        tabBarController?.tabBar.isHidden = false
    }
    
    
    private func setupSubviews() {
        view.addSubview(gradient)
        view.addSubview(titleLabel)
        view.addSubview(tableView)
    }
    
    
    private func configureTableView() {
        tableView.register(CalculatorTableViewCell.self, forCellReuseIdentifier: CalculatorTableViewCell.reuseID)
        tableView.backgroundColor = .clear
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            gradient.topAnchor.constraint(equalTo: view.topAnchor),
            gradient.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradient.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gradient.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.calculatorViewControllerTableViewTopAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.calculatorViewControllerTableViewHorizontalAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.calculatorViewControllerTableViewHorizontalAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.calculatorViewControllerTableViewBottomAnchor)
        ])
    }
}


extension CalculatorViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navigationController else { return }
        var type: CalculatorType = .bodyMassIndex
        
        switch indexPath.row {
        case 0: type = .bodyMassIndex
        case 1: type = .fatPercentage
        case 2: type = .dailyCalorieRequirement
        default: break
        }
        
        let calculationCoordinator = CalculationCoordinator(navigationController: navigationController, calculatorType: type)
        calculationCoordinator.start()
    }
}


extension CalculatorViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CalculatorTableViewCell.reuseID, for: indexPath) as? CalculatorTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        
        tableView.separatorStyle = .none
        
        var type: CalculatorType = .bodyMassIndex
        
        switch indexPath.row {
        case 0: type = .bodyMassIndex
        case 1: type = .fatPercentage
        case 2: type = .dailyCalorieRequirement
        default: break
        }
        
        cell.setTitle(type.rawValue)
        return cell
    }
}
