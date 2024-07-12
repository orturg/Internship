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
//                try? FirebaseService.shared.logOut()
        if FirebaseService.shared.isUserCreated() {
            getUser { [weak self] user in
                guard let self = self else { return }
                guard let user else {
                    return
                }
                
                if let sex = user.sex, !sex.isEmpty {
                    let tabBarCoordinator = TabBarCoordinator(navigationController: self.navigationController, titleText: user.userName, isMan: user.sex == "male")
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
        FirebaseService.shared.getUser { result in
            switch result {
            case .success(let user):
                completion(user)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
}
