//
//  HomeViewModel.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 29.06.2024.
//

import UIKit

final class HomeViewModel {
    weak var homeCoordinator: HomeCoordinator?
    var titleText: String?
    var isMan: Bool
    var user: RegistrationData?
    var avatarImage = UIImage.maleAvatarPlaceholder
    
    init(titleText: String?, isMan: Bool) {
        self.titleText = titleText
        self.isMan = isMan
        getImage()
    }
    
    
    func configureLabels(titleLabel: UILabel, nameLabel: UILabel) {
        titleLabel.text = titleText
        nameLabel.text = user?.userName
    }
    
    
    func getUser(vc: HomeViewController) {
        getImage()
        
        FirebaseService.shared.getUser { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                self.user = user
                vc.configureLabels()
                vc.set(avatarImage)
            case .failure(let error):
                vc.showAlert(vc: vc, error: error)
            }
        }
    }
    
    
    func avatarImageViewAction(navigationController: UINavigationController?) {
        guard let navigationController else { return }
        
        let profileCoordinator = ProfileCoordinator(navigationController: navigationController, isMan: isMan)
        profileCoordinator.start()
    }
    
    
    private func getImage() {
        FirebaseService.shared.getImage { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let image):
                self.avatarImage = image
            case .failure(_):
                self.avatarImage = UIImage.maleAvatarPlaceholder
            }
        }
    }
}
