//
//  ChooseActivityLevelViewModel.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 15.08.2024.
//

import Foundation

enum DailyCaloriesRateActivityLevel: Double, CaseIterable {
  case sitting = 1.2
  case light = 1.38
  case middle = 1.56
  case high = 1.73
  case extremal = 1.95
}

enum DailyCaloriesRateActivity: String, CaseIterable {
  case sitting = "sedentary lifestyle"
  case light = "light activity (1 to 3 times a week)"
  case middle = "medium activity (training 3-5 times a week)"
  case high = "high activity (training 6-7 times a week)"
  case extremal = "extremely high activity"
}


final class ChooseActivityLevelViewModel {
    weak var coordinator: ChooseActivityLevelCoordinator?
    
    var selectedIndexPath: IndexPath?
    weak var chooseActivityDelegate: ChooseActivityDelegate?
    
    func confirmButtonAction() {
        chooseActivityDelegate?.selectedOptionIndexPath = selectedIndexPath
        chooseActivityDelegate?.setActivityLevel(level: DailyCaloriesRateActivity.allCases[chooseActivityDelegate?.selectedOptionIndexPath?.row ?? 0])
    }
}
