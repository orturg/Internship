//
//  MusclesViewModel.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 06.07.2024.
//
import UIKit


protocol MusclesViewModelDelegate: AnyObject {
    func didResetExercises()
}


final class MusclesViewModel {
    weak var musclesCoordinator: MusclesCoordinator?
    var exerciseList: [ExerciseList] = []
    var sectionExpanded: [Bool] = []
    var selectedCountForSection: [Int] = []
    var selectedExercises: Set<IndexPath> = []
    var isResetButtonActive = false
    
    weak var delegate: MusclesViewModelDelegate?

    
    func getExercises(completion: @escaping(Result<String?, DataBaseError>) -> Void) {
        var data: Data = Data()
        
        guard let file = Bundle.main.url(forResource: TextValues.jsonFileName, withExtension: nil) else {
            completion(.failure(.failedDecoding))
            return
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            completion(.failure(.failedDecoding))
        }
        
        let decoder = JSONDecoder()
        
        do {
            exerciseList = try decoder.decode([ExerciseList].self, from: data)
            sectionExpanded = Array(repeating: false, count: exerciseList.count)
            completion(.success(nil))
        } catch {
            completion(.failure(.failedDecoding))
        }
    }
    
    
    func resetButtonAction() {
        selectedCountForSection = Array(repeating: 0, count: exerciseList.count)
        selectedExercises.removeAll()
        isResetButtonActive = false
        delegate?.didResetExercises()
    }
}
