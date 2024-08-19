//
//  CalculationViewModel.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 13.08.2024.
//

import UIKit

enum BMILevel: String {
    case tooLow = "Severe weight deficiency"
    case low = "Underweight"
    case normal = "Normal"
    case high = "Overweight"
    case toHigh = "Obesity"
    case extremlyHigh = "Obesity is severe"
    case toExtremlyHigh = "Very severe obesity"
    case empty = "Enter the correct values"
}

enum FatPercentLevel: String {
  case toLow = "Severe underweight"
  case low = "Severely underweight"
  case notEnough = "Underweight"
  case normal = "Norma"
  case high = "Overweight"
  case toHigh = "Obesity"
  case empty = "Enter the correct values"
}


protocol ChooseActivityDelegate: AnyObject {
    var selectedOptionIndexPath: IndexPath? { get set }
    func setActivityLevel(level: DailyCaloriesRateActivity)
}


protocol ChooseActivityLevelDelegate: AnyObject {
    func activityLevelButtonChangeStyle()
}


final class CalculationViewModel {
    weak var coordinator: CalculationCoordinator?
    var calculatorType: CalculatorType?
    var BMI: Double = 0
    var BMIDescription: BMILevel = .empty
    
    var fatPercent: Double = 0
    var fatPercentLevel: FatPercentLevel = .empty
    
    var dailyCaloriesRateActivityLevel: DailyCaloriesRateActivity?
    
    var selectedOptionIndexPath: IndexPath?
    
    
    weak var calculationDelegate: CalculationDelegate?
    weak var chooseActivityLevelDelegate: ChooseActivityLevelDelegate?
    var isCalculateButtonActive = true
    
    func calculateBMI(height: Double, weight: Double) {
        guard isCalculateButtonActive else { return }
        BMI = Double(weight / ((height * height) / 10000))
        
        switch BMI {
        case 0.01...16.0: BMIDescription = .tooLow
        case 16...18.5: BMIDescription = .low
        case 18.5...24.99: BMIDescription = .normal
        case 25...30: BMIDescription = .high
        case 30...35: BMIDescription = .extremlyHigh
        case 35...40: BMIDescription = .toExtremlyHigh
        case 40...: BMIDescription = .toExtremlyHigh
        default: BMIDescription = .empty
        }
        
        calculationDelegate?.setResultLabel(result: BMI)
        calculationDelegate?.setDescriptionLabel(with: BMIDescription.rawValue)
    }
    
    
    func calculateFatPercentage(isMale: Bool, height: Double, neck: Double, waist: Double, hips: Double = 0) {
        guard isCalculateButtonActive else { return }
        
        fatPercent = isMale ? (495 / (1.0324 - 0.19077 * log10(waist - neck) + 0.15456 * log10(height))) - 450
        : (495 / (1.2958 - 0.35 * log10(waist + hips - neck) + 0.221 * log10(height))) - 450
        
        switch fatPercent {
        case 2.0...5.0: fatPercentLevel = .toLow
        case 5.0...13.0: fatPercentLevel = .low
        case 13.0...17.0: fatPercentLevel = .notEnough
        case 17.0...22.0: fatPercentLevel = .normal
        case 22.0...29.0: fatPercentLevel = .high
        case 29.0... : fatPercentLevel = .toLow
        default: fatPercentLevel = .empty
        }
        
        calculationDelegate?.setResultLabel(result: fatPercent)
        calculationDelegate?.setDescriptionLabel(with: fatPercentLevel.rawValue)
    }
    
    
    func calculateCaloriesPerDay(isMale: Bool, height: Double, weight: Double, age: Int) {
        guard isCalculateButtonActive else { return }
        
        let sexConstant = isMale ? 5 : -161
        
        var dailyCaloriesConstant: Double = 0
        
        switch dailyCaloriesRateActivityLevel {
        case .sitting:
            dailyCaloriesConstant = 1.2
        case .light:
            dailyCaloriesConstant = 1.38
        case .middle:
            dailyCaloriesConstant = 1.56
        case .high:
            dailyCaloriesConstant = 1.73
        case .extremal:
            dailyCaloriesConstant = 1.95
        case nil:
            break
        }
        
        let dailyCalories = (10 * weight + 6.25 * height - 5 * Double(age) + Double(sexConstant)) * dailyCaloriesConstant
        
        calculationDelegate?.setResultLabel(result: dailyCalories)
        calculationDelegate?.setDescriptionLabel(with: TextValues.caloriesDay)
    }
    
    
    func chooseActivityLevelButtonAction(navigationController: UINavigationController?) {
        guard let navigationController else { return }
        
        let chooseActivityLevelCoordinator = ChooseActivityLevelCoordinator(navigationController: navigationController)
        chooseActivityLevelCoordinator.chooseActivityDelegate = self
        chooseActivityLevelCoordinator.start()
    }
}

extension CalculationViewModel: ChooseActivityDelegate {
    
    func setActivityLevel(level: DailyCaloriesRateActivity) {
        self.dailyCaloriesRateActivityLevel = level
        chooseActivityLevelDelegate?.activityLevelButtonChangeStyle()
    }
}
