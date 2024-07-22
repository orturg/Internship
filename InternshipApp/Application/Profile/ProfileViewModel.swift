//
//  ProfileViewModel.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 21.07.2024.
//

import UIKit

final class ProfileViewModel {
    weak var coordinator: ProfileCoordinator?
    var isMan: Bool
    var nameTextFieldText: String?
    var isTextChanged = false
    var isAvatarChanged = false
    var avatarImage = UIImage()
    
    
    init(isMan: Bool) {
        self.isMan = isMan
        FirebaseService.shared.getImage { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let image):
                self.avatarImage = image
            case .failure(_):
                self.avatarImage = UIImage.profileAvatarPlaceholder
            }
        }
    }
    
    
    
    func getUser(vc: ProfileViewController) {
        FirebaseService.shared.getUser { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let user):
                guard let user else { return }
                vc.set(user.userName)
                vc.set(self.avatarImage)
            case .failure(_):
                vc.set("")
            }
        }
    }
    
    
    func saveButtonAction(saveButton: CustomButton, nameTextField: CustomTextField, vc: UIViewController, navigationController: UINavigationController?) {
        guard let navigationController else { return }
        
        if isTextChanged && !nameTextField.getText().isEmpty {
            FirebaseService.shared.updateUsername(name: nameTextField.getText()) { result in
                switch result {
                case .success(_):
                    let alertCoordinator = EmptyAlertCoordinator(navigationController: navigationController, messageText: TextValues.successSavedProfile)
                    alertCoordinator.start()
                case .failure(_):
                    vc.showAlert(vc: vc, error: .errorUpdatingUser)
                }
            }
            nameTextFieldText = nameTextField.getText()
            isTextChanged = false
            saveButton.set(.appSecondary)
        }
    }
    
    
    func updateAvatar(saveButton: CustomButton, vc: UIViewController, navigationController: UINavigationController?) {
        guard let navigationController else { return }
        
        if isAvatarChanged {
            FirebaseService.shared.updateAvatar(image: avatarImage) { result in
                switch result {
                case .success(_):
                    let alertCoordinator = EmptyAlertCoordinator(navigationController: navigationController, messageText: TextValues.successSavedProfile)
                    alertCoordinator.start()
                case .failure(_):
                    vc.showAlert(vc: vc, error: .errorUpdatingUser)
                }
            }
        }
        
        isAvatarChanged = false
        saveButton.set(.appSecondary)
    }
}

