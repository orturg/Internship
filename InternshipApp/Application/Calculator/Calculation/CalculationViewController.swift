//
//  CalculationViewController.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 13.08.2024.
//

import UIKit

protocol CalculationDelegate: AnyObject {
    func setResultLabel(result: Double)
    func setDescriptionLabel(with text: String)
}

final class CalculationViewController: BaseViewController, ChooseActivityLevelDelegate {
    
    var vm: CalculationViewModel?
    
    @IBOutlet weak var titleLabel: UILabel!
    
    private let backButton = UIImageView()
    private let calculatorNameLabel = UILabel()
    private var parametersStackView = UIStackView()
    private var parametersSubviews: [CalculationViewStack] = []
    private let resultWindow = UIView()
    private let resultLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let calculateButton = CustomRoundedRectangleButton(buttonBackgroundColor: .appYellow, buttonText: TextValues.calculate, textColor: .black, height: Constants.customRoundedRectangleButtonHeight, width: Constants.customRoundedRectangleButtonWidth)
    private let segmentedControl = CustomSegmentedControl(items: [TextValues.superManLabel, TextValues.superGirlLabel])
    private let chooseActivityLevelButton = CustomRoundedRectangleButton(buttonBackgroundColor: .clear, buttonText: TextValues.chooseActivityLevel, textColor: .appWhite, height: Constants.customRoundedRectangleButtonHeight, width: Constants.customRoundedRectangleButtonWidth)
    
    var selectedOptionIndexPath: IndexPath?
    
    lazy var gradient: GradientView = {
        GradientView(width: Constants.gradientViewWidth, height: view.bounds.height, topColor: .clear, bottomColor: .black)
    }()
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
    private func configure() {
        configureVC()
        configureScrollView()
        configureBackButton()
        configureCalculatorNameLabel()
        configureSegmentedControl()
        configureParametersStackView()
        configureResultWindow()
        configureResultLabel()
        configureDescriptionLabel()
        configureCalculateButton()
        configureChooseActivityLevelButton()
        setupSubviews()
        setupLayoutConstraints()
    }
    
    
    private func configureVC() {
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
        vm?.calculationDelegate = self
        vm?.chooseActivityLevelDelegate = self
    }
    
    
    private func setupSubviews() {
        view.addSubview(gradient)
        view.addSubview(scrollView)
        view.addSubview(titleLabel)
        view.addSubview(backButton)
        view.addSubview(parametersStackView)
        view.addSubview(calculateButton)
    }
    
    
    private func configureScrollView() {
        scrollView.addSubview(contentView)
        
        contentView.addSubview(calculatorNameLabel)
        contentView.addSubview(parametersStackView)
        contentView.addSubview(resultWindow)
        contentView.addSubview(resultLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(calculateButton)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func configureBackButton() {
        backButton.image = UIImage.back
        backButton.isUserInteractionEnabled = true
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissVC))
        backButton.addGestureRecognizer(tapGestureRecognizer)
    }
    
    
    @objc private func dismissVC() {
        navigationController?.popViewController(animated: true)
    }
    
    
    private func configureCalculatorNameLabel() {
        calculatorNameLabel.text = vm?.calculatorType?.rawValue
        calculatorNameLabel.font = UIFont(name: TextValues.sairaMedium, size: Constants.calculationViewControllerCalculatorNameLabelSize)
        calculatorNameLabel.textColor = .appWhite
        calculatorNameLabel.numberOfLines = 2
        calculatorNameLabel.textAlignment = .center
        
        calculatorNameLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func configureSegmentedControl() {
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.selectedColor = .appYellow
        segmentedControl.selectedTextColor = .black
        segmentedControl.textColor = .appYellow
        segmentedControl.borderColor = .appYellow
        segmentedControl.borderWidth = 1
        
        segmentedControl.addTarget(self, action: #selector(segmentedControlDidChange), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    @objc private func segmentedControlDidChange() {
        if vm?.calculatorType == .fatPercentage {
            setupParametersStackView()
            setupParameterStackHeight()
        }
    }
    
    
    private func setupSegmentControl() {
        guard let vm else { return }
        if vm.calculatorType == .fatPercentage || vm.calculatorType == .dailyCalorieRequirement {
            contentView.addSubview(segmentedControl)
            view.addSubview(segmentedControl)
            
            
            NSLayoutConstraint.activate([
                segmentedControl.topAnchor.constraint(equalTo: calculatorNameLabel.bottomAnchor, constant: Constants.calculationViewControllerSegmentedControlBottomAnchor),
                segmentedControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.calculationViewControllerSegmentedControlHorizontalAnchor),
                segmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.calculationViewControllerSegmentedControlHorizontalAnchor),
                segmentedControl.heightAnchor.constraint(equalToConstant: Constants.calculationViewControllerSegmentedControlHeightAnchor)
            ])
        }
    }
    
    
    private func configureParametersStackView() {
        parametersStackView.axis = .vertical
        parametersStackView.spacing = Constants.calculationViewControllerParametersStackViewSpacing
        
        parametersStackView.translatesAutoresizingMaskIntoConstraints = false
        
        switch vm?.calculatorType {
        case .bodyMassIndex:
            for index in 0..<2 {
                let stackView = CalculationViewStack(titleLabelText: index == 0 ? TextValues.height : TextValues.weight)
                stackView.textField.delegate = self
                parametersStackView.addArrangedSubview(stackView)
                parametersSubviews.append(stackView)
            }
        case .fatPercentage:
            let cellAmounts = segmentedControl.selectedSegmentIndex == 0 ? 3 : 4
            for index in 0..<cellAmounts {
                let stackView = CalculationViewStack(titleLabelText: index == 0 ? TextValues.height : (index == 1 ? TextValues.neck : (index == 2 ? TextValues.waist : TextValues.hips)))
                stackView.textField.delegate = self
                parametersStackView.addArrangedSubview(stackView)
                parametersSubviews.append(stackView)
            }
        case .dailyCalorieRequirement:
            for index in 0..<3 {
                let stackView = CalculationViewStack(titleLabelText: index == 0 ? TextValues.height : (index == 1 ? TextValues.weight : TextValues.age))
                stackView.textField.delegate = self
                parametersStackView.addArrangedSubview(stackView)
                parametersSubviews.append(stackView)
            }
        case nil:
            break
        }
    }
    
    
    private func setupParametersStackView() {
        parametersStackView.removeFromSuperview()
        parametersStackView = UIStackView()
        parametersSubviews.removeAll()
        
        contentView.addSubview(parametersStackView)
        view.addSubview(parametersStackView)
        configureParametersStackView()
        
        setupLayoutConstraints()
    }
    
    
    private func configureChooseActivityLevelButton() {
        chooseActivityLevelButton.layer.borderWidth = 1
        chooseActivityLevelButton.layer.borderColor = UIColor.appWhite.cgColor
        chooseActivityLevelButton.titleLabel?.lineBreakMode = .byTruncatingTail
        chooseActivityLevelButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        
        chooseActivityLevelButton.addTarget(self, action: #selector(chooseActivityLevelButtonAction), for: .touchUpInside)
        chooseActivityLevelButton.addTarget(vm?.dailyCaloriesRateActivityLevel, action: #selector(activityLevelDidChange), for: .valueChanged)
    }
    
    
    @objc private func activityLevelDidChange() {
        activityLevelButtonChangeStyle()
    }
    
    
    @objc private func chooseActivityLevelButtonAction() {
        vm?.chooseActivityLevelButtonAction(navigationController: navigationController)
    }
    
    
    private func configureResultWindow() {
        resultWindow.layer.borderWidth = 1
        resultWindow.layer.borderColor = UIColor.appGray.cgColor
        resultWindow.layer.cornerRadius = 8
        
        resultWindow.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func configureResultLabel() {
        resultLabel.text = vm?.calculatorType == .dailyCalorieRequirement ? "" : "Fill in your data"
        resultLabel.font = UIFont(name: TextValues.sairaBold, size: Constants.calculationViewControllerResultLabelSize)
        resultLabel.textColor = .appYellow
        
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func resultWindowChangeStyle() {
        guard let vm else { return }
        resultWindow.layer.borderColor = vm.isCalculateButtonActive ? UIColor.appGray.cgColor : UIColor.appRed.cgColor
        
        resultLabel.textColor = vm.isCalculateButtonActive ? .appYellow : .appRed
        resultLabel.text = vm.isCalculateButtonActive ? "" : TextValues.enterTheCorrectValues
        resultLabel.font = vm.isCalculateButtonActive ? UIFont(name: TextValues.sairaBold, size: Constants.calculationViewControllerResultLabelSize) : UIFont(name: TextValues.sairaThin, size: Constants.calculationViewControllerResultLabelErrorSize)
        
        if vm.calculatorType != .dailyCalorieRequirement {
            descriptionLabel.removeFromSuperview()
        }
    }
    
    
    private func configureDescriptionLabel() {
        descriptionLabel.text = vm?.calculatorType == .dailyCalorieRequirement ? TextValues.caloriesDay : ""
        descriptionLabel.font = UIFont(name: TextValues.sairaThin, size: Constants.calculationViewControllerDescriptionLabelSize)
        descriptionLabel.textColor = .appWhite
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func configureCalculateButton() {
        calculateButton.addTarget(self, action: #selector(calculateButtonAction), for: .touchUpInside)
    }
    
    
    @objc private func calculateButtonAction() {
        switch vm?.calculatorType {
        case .bodyMassIndex:
            bodyMassIndexAction()
        case .fatPercentage:
            fatPercentageAction()
        case .dailyCalorieRequirement:
            dailyCaloriesAction()
        case nil:
            break
        }
    }
    
    
    private func bodyMassIndexAction() {
        var height: Double = 0
        var weight: Double = 0
        
        let heightStack = parametersSubviews[0]
        let weightStack = parametersSubviews[1]
        
        if heightStack.getText().isEmpty || heightStack.getText() == "0" {
            vm?.isCalculateButtonActive = false
            heightStack.makeTextFieldRed()
        }
        height = Double(heightStack.getText()) ?? 0
        
        if weightStack.getText().isEmpty || weightStack.getText() == "0" {
            vm?.isCalculateButtonActive = false
            weightStack.makeTextFieldRed()
        }
        
        weight = Double(weightStack.getText()) ?? 0
        resultWindowChangeStyle()
        vm?.calculateBMI(height: height, weight: weight)
        vm?.isCalculateButtonActive = true
    }
    
    
    private func fatPercentageAction() {
        var height: Double = 0
        var neck: Double = 0
        var waist: Double = 0
        var hips: Double = 0
        
        let heightStack = parametersSubviews[0]
        let neckStack = parametersSubviews[1]
        let waistStack = parametersSubviews[2]
        
        if heightStack.getText().isEmpty || heightStack.getText() == "0" {
            vm?.isCalculateButtonActive = false
            heightStack.makeTextFieldRed()
        }
        
        height = Double(heightStack.getText()) ?? 0
        
        if neckStack.getText().isEmpty || neckStack.getText() == "0" {
            vm?.isCalculateButtonActive = false
            neckStack.makeTextFieldRed()
        }
        
        neck = Double(neckStack.getText()) ?? 0
        
        if waistStack.getText().isEmpty || waistStack.getText() == "0" {
            vm?.isCalculateButtonActive = false
            waistStack.makeTextFieldRed()
        }
        
        waist = Double(waistStack.getText()) ?? 0
        
        if segmentedControl.selectedSegmentIndex == 1 {
            let hipsStack = parametersSubviews[3]
            
            if hipsStack.getText().isEmpty || hipsStack.getText() == "0" {
                vm?.isCalculateButtonActive = false
                hipsStack.makeTextFieldRed()
            }
            
            hips = Double(hipsStack.getText()) ?? 0
        }
        
        resultWindowChangeStyle()
        vm?.calculateFatPercentage(isMale: segmentedControl.selectedSegmentIndex == 0, height: height, neck: neck, waist: waist, hips: hips)
        vm?.isCalculateButtonActive = true
    }
    
    
    private func dailyCaloriesAction() {
        var height: Double = 0
        var weight: Double = 0
        var age: Int = 0
        
        let heightStack = parametersSubviews[0]
        let weightStack = parametersSubviews[1]
        let ageStack = parametersSubviews[2]
        
        if heightStack.getText().isEmpty || heightStack.getText() == "0" {
            vm?.isCalculateButtonActive = false
            heightStack.makeTextFieldRed()
        }
        
        height = Double(heightStack.getText()) ?? 0
        
        if weightStack.getText().isEmpty || weightStack.getText() == "0" {
            vm?.isCalculateButtonActive = false
            weightStack.makeTextFieldRed()
        }
        
        weight = Double(weightStack.getText()) ?? 0
        
        if ageStack.getText().isEmpty || ageStack.getText() == "0" {
            vm?.isCalculateButtonActive = false
            ageStack.makeTextFieldRed()
        }
        
        age = Int(ageStack.getText()) ?? 0
        
        if chooseActivityLevelButton.titleLabel?.text == TextValues.chooseActivityLevel {
            vm?.isCalculateButtonActive = false
        }
        
        resultWindowChangeStyle()
        activityLevelButtonChangeStyle()
        vm?.calculateCaloriesPerDay(isMale: segmentedControl.selectedSegmentIndex == 0, height: height, weight: weight, age: age)
        vm?.isCalculateButtonActive = true
    }
    
    
    internal func activityLevelButtonChangeStyle() {
        guard let vm else { return }
        
        chooseActivityLevelButton.layer.borderColor = vm.isCalculateButtonActive ? UIColor.appWhite.cgColor : UIColor.appRed.cgColor
        chooseActivityLevelButton.setTitleColor(vm.isCalculateButtonActive ? UIColor.appWhite : UIColor.appRed, for: .normal)
        chooseActivityLevelButton.setTitle(vm.dailyCaloriesRateActivityLevel?.rawValue ?? TextValues.chooseActivityLevel, for: .normal)
    }
    
    
    private func setupParameterStackHeight() {
        switch vm?.calculatorType {
        case .bodyMassIndex:
            NSLayoutConstraint.activate([
                parametersStackView.topAnchor.constraint(equalTo: calculatorNameLabel.bottomAnchor, constant: Constants.calculationViewControllerParametersStackViewTopAnchor),
                parametersStackView.heightAnchor.constraint(equalToConstant: Constants.calculationViewControllerParametersStackViewHeightAnchor),
            ])
        case .fatPercentage:
            
            if segmentedControl.selectedSegmentIndex == 0 {
                NSLayoutConstraint.activate([
                    parametersStackView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: Constants.calculationViewControllerFatPercentageSupermanParametersStackViewTopAnchor),
                    parametersStackView.heightAnchor.constraint(equalToConstant: Constants.calculationViewControllerFatPercentageSupermanParametersStackViewHeightAnchor),
                ])
            } else {
                NSLayoutConstraint.activate([
                    parametersStackView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: Constants.calculationViewControllerFatPercentageSupermanParametersStackViewTopAnchor),
                    parametersStackView.heightAnchor.constraint(equalToConstant: Constants.calculationViewControllerFatPercentageSuperwomanParametersStackViewHeightAnchor),
                ])
            }
            
        case .dailyCalorieRequirement:
            NSLayoutConstraint.activate([
                parametersStackView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: Constants.calculationViewControllerFatPercentageSupermanParametersStackViewTopAnchor),
                parametersStackView.heightAnchor.constraint(equalToConstant: Constants.calculationViewControllerFatPercentageSupermanParametersStackViewHeightAnchor),
            ])
        case nil:
            break
        }
        
        NSLayoutConstraint.activate([
            parametersStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.calculationViewControllerParametersStackViewHorizontalAnchor),
            parametersStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.calculationViewControllerParametersStackViewHorizontalAnchor),
        ])
    }
    
    
    private func setupChooseActivityLevelButton() {
        if vm?.calculatorType == .dailyCalorieRequirement {
            contentView.addSubview(chooseActivityLevelButton)
            view.addSubview(chooseActivityLevelButton)
            
            NSLayoutConstraint.activate([
                chooseActivityLevelButton.topAnchor.constraint(equalTo: parametersStackView.bottomAnchor, constant: Constants.calculationViewControllerChooseActivityLevelButtonTopAnchor),
                chooseActivityLevelButton.leadingAnchor.constraint(equalTo: parametersStackView.leadingAnchor),
                chooseActivityLevelButton.trailingAnchor.constraint(equalTo: parametersStackView.trailingAnchor),
                chooseActivityLevelButton.heightAnchor.constraint(equalToConstant: Constants.calculationViewControllerChooseActivityLevelButtonHeightAnchor)
            ])
        }
    }
    
    
    private func setupResultElements() {
        switch vm?.calculatorType {
        case .bodyMassIndex:
            NSLayoutConstraint.activate([
                resultWindow.topAnchor.constraint(equalTo: parametersStackView.bottomAnchor, constant: Constants.calculationViewControllerResultWindowTopAnchor),
            ])
        case .fatPercentage:
            NSLayoutConstraint.activate([
                resultWindow.topAnchor.constraint(equalTo: parametersStackView.bottomAnchor, constant: Constants.calculationViewControllerResultWindowTopAnchor),
            ])
        case .dailyCalorieRequirement:
            NSLayoutConstraint.activate([
                resultWindow.topAnchor.constraint(equalTo: chooseActivityLevelButton.bottomAnchor, constant: Constants.calculationViewControllerResultWindowTopAnchor),
            ])
        case nil:
            break
        }
        
        NSLayoutConstraint.activate([
            resultWindow.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.calculationViewControllerResultWindowHorizontalAnchor),
            resultWindow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.calculationViewControllerResultWindowHorizontalAnchor),
            resultWindow.heightAnchor.constraint(equalToConstant: Constants.calculationViewControllerResultWindowHeightAnchor),
        ])
    }
    
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            gradient.topAnchor.constraint(equalTo: view.topAnchor),
            gradient.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradient.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gradient.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 108),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.backButtonLeadingPadding),
            backButton.widthAnchor.constraint(equalToConstant: Constants.backButtonWidth),
            backButton.heightAnchor.constraint(equalToConstant: Constants.backButtonHeight),
            
            calculatorNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.calculationViewControllerCalculatorNameLabelTopAnchor),
            calculatorNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.calculationViewControllerCalculatorNameLabelHorizontalAnchor),
            calculatorNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.calculationViewControllerCalculatorNameLabelHorizontalAnchor),
            
            calculateButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.calculationViewControllerCalculateButtonHorizontalAnchor),
            calculateButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.calculationViewControllerCalculateButtonHorizontalAnchor),
            calculateButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.calculationViewControllerCalculateButtonBottomAnchor),
            
            resultLabel.centerXAnchor.constraint(equalTo: resultWindow.centerXAnchor),
            resultLabel.centerYAnchor.constraint(equalTo: resultWindow.centerYAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: resultWindow.bottomAnchor, constant: Constants.calculationViewControllerDescriptionLabelTopAnchor),
            descriptionLabel.centerXAnchor.constraint(equalTo: resultWindow.centerXAnchor),
        ])
        setupSegmentControl()
        setupParameterStackHeight()
        setupChooseActivityLevelButton()
        setupResultElements()
    }
}


extension CalculationViewController: CalculationDelegate {
    func setResultLabel(result: Double) {
        resultLabel.text = String(format: "%.2f", result)
    }
    
    
    func setDescriptionLabel(with text: String) {
        descriptionLabel.text = text
        
        contentView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: resultWindow.bottomAnchor, constant: Constants.calculationViewControllerDescriptionLabelSize),
            descriptionLabel.centerXAnchor.constraint(equalTo: resultWindow.centerXAnchor),
        ])
    }
}


extension CalculationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let index = parametersSubviews.firstIndex(where: { $0.textField == textField }) {
            if index < parametersSubviews.count - 1 {
                parametersSubviews[index + 1].textField.becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
            }
        }
        return true
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}




