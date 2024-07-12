//
//  HomeViewModel.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 29.06.2024.
//

import Foundation

final class HomeViewModel {
    weak var homeCoordinator: HomeCoordinator?
    var titleText: String?
    var isMan: Bool
    var user: RegistrationData?
    
    init(titleText: String?, isMan: Bool) {
        self.titleText = titleText
        self.isMan = isMan
    }
    
    
    func getUser(completion: @escaping () -> Void) {
        FirebaseService.shared.getUser { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                self.user = user
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
