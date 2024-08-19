//
//  AppCoordinator.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 29.06.2024.
//

import UIKit
import FirebaseAuth

final class AppCoordinator: Coordinator {
    private var window: UIWindow?
    
    private var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        
        return navigationController
    }()
    
    
    init(window: UIWindow?) {
        self.window = window
        self.window?.rootViewController = navigationController
    }
    
    
    func start() {
//         if you want to logout session without deleting app uncomment below
        
//        try? FirebaseService.shared.logOut()
        
        if FirebaseService.shared.isAppDeleted() {
            try? FirebaseService.shared.logOut()
        }
        if FirebaseService.shared.isUserCreated() {
            getUser { [weak self] user in
                guard let self = self else { return }
                guard let user else {
                    return
                }
                if let sex = user.sex, !sex.isEmpty {
                    let tabBarCoordinator = TabBarCoordinator(navigationController: self.navigationController, titleText: user.sex == TextValues.male ? TextValues.superManLabel : TextValues.superGirlLabel, isMan: user.sex == TextValues.male)
                    tabBarCoordinator.start()
                } else {
                    let startCoordinator = StartCoordinator(navigationController: navigationController)
                    startCoordinator.start()
                }
            }
        } else {
            let signUpCoordinator = SignUpCoordinator(navigationController: navigationController)
            signUpCoordinator.start()
        }
    }
    
    
    private func getUser(completion: @escaping (RegistrationData?) -> Void) {
        FirebaseService.shared.getUser { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let user):
                completion(user)
            case .failure(let error):
                self.navigationController.showAlert(vc: navigationController, error: error)
            }
        }
    }
}
