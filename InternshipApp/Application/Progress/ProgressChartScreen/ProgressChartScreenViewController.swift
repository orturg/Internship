//
//  ProgressChartScreenViewController.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 30.07.2024.
//

import UIKit

final class ProgressChartScreenViewController: UIViewController {
    
    var vm: ProgressChartScreenViewModel?
    
    private var backButton = UIImageView()
    private var titleLabel = UILabel()
    private var centerLabel = UILabel()
    private var dateLabel = UILabel()
    private var scrollView = UIScrollView()
    lazy private var chartView: ChartView = {
        ChartView(name: vm?.optionData?.optionName.rawValue ?? "")
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
    private func configure() {
        configureVC()
        configureBackButton()
        configureTitleLabel()
        configureCenterLabel()
        configureDateLabel()
        configureChartView()
        configureScrollView()
        setupSubviews()
        setupLayoutConstraints()
    }
    
    private func setupSubviews() {
        view.addSubview(centerLabel)
        view.addSubview(dateLabel)
        view.addSubview(scrollView)
        scrollView.addSubview(chartView)
    }
    
    
    private func configureVC() {
        tabBarController?.tabBar.isHidden = true
    }
    
    
    private func configureBackButton() {
        backButton.image = UIImage.back
        backButton.isUserInteractionEnabled = true
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissVC))
        backButton.addGestureRecognizer(tapGestureRecognizer)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    
    @objc private func dismissVC() {
        navigationController?.popViewController(animated: true)
    }
    
    
    private func configureTitleLabel() {
        titleLabel.text = "\(vm?.optionData?.optionName.rawValue ?? "") \(TextValues.chart)"
        titleLabel.textColor = .appWhite
        titleLabel.font = UIFont(name: TextValues.sairaMedium, size: Constants.progressChartScreenTitleLabelSize)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        navigationItem.titleView = titleLabel
    }
    
    
    private func configureCenterLabel() {
        centerLabel.text = "\(vm?.optionData?.optionName.rawValue ?? ""), \(vm?.optionData?.optionName.rawValue == TextValues.weight ? TextValues.kg : TextValues.cm)"
        centerLabel.textColor = .appWhite
        centerLabel.font = UIFont(name: TextValues.sairaRegular, size: Constants.progressChartScreenCenterLabelSize)
        
        centerLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func configureDateLabel() {
        let timestamp = Date(timeIntervalSince1970: vm?.optionData?.dateArray.first ?? 0)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let dateString = dateFormatter.string(from: timestamp)
        
        dateLabel.text = "\(TextValues.progressChartScreenDateLabelText) \(dateString)"
        dateLabel.textColor = .appSecondary
        dateLabel.font = UIFont(name: TextValues.sairaMedium, size: Constants.progressChartScreenDateLabelSize)
        dateLabel.textAlignment = .center
        dateLabel.numberOfLines = 0
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func configureScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func configureChartView() {
        chartView.translatesAutoresizingMaskIntoConstraints = false
        
        chartView.valueArray = vm?.optionData?.valueArray ?? []
        chartView.dateArray = vm?.optionData?.dateArray ?? []
    }
    
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            centerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.progressChartScreenCenterLabelTopAnchor),
            centerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: centerLabel.bottomAnchor, constant: Constants.progressChartScreenDateLabelTopAnchor),
            dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.progressChartScreenDateLabelHorizontalAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.progressChartScreenDateLabelHorizontalAnchor),
            
            scrollView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: Constants.progressChartScreenScrollViewTopAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.progressChartScreenScrollViewHorizontalAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.progressChartScreenScrollViewHorizontalAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.progressChartScreenScrollViewBottomAnchor),
            
            chartView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            chartView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            chartView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            chartView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            chartView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            chartView.widthAnchor.constraint(equalTo: view.widthAnchor)
            
        ])
    }
}
