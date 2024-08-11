//
//  ExerciseDetailCoordinator.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 09.08.2024.
//

import UIKit

final class ExerciseDetailCoordinator: Coordinator {
    var navigationController: UINavigationController
    var exercise: Exercise
    
    init(navigationController: UINavigationController, exercise: Exercise) {
        self.navigationController = navigationController
        self.exercise = exercise
    }
    
    
    func start() {
        let exerciseDetailVC = ExerciseDetailViewController()
        let exerciseDetailVM = ExerciseDetailViewModel()
        
        exerciseDetailVC.vm = exerciseDetailVM
        exerciseDetailVC.vm?.coordinator = self
        exerciseDetailVC.vm?.exercise = exercise
        
        navigationController.pushViewController(exerciseDetailVC, animated: true)
    }
}
