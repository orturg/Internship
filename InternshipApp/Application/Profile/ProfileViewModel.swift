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
    var optionCells: [OptionCell] = []
    var textFieldCells: [TextFieldCell] = []
    weak var delegate: ProfileVCDelegate?
    var tableView: UITableView?
    var isTableViewActive = false
    
    
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
    
    
    func getData(completion: @escaping () -> Void) {
        FirebaseService.shared.getOptionData { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let options):
                options?.forEach {
                    let textFieldCell = TextFieldCell()
                    textFieldCell.setTextFieldTitle(text: $0.optionName.rawValue)
                    textFieldCell.setTextFieldText(text: String($0.valueArray.count == 1 ? $0.valueArray[0] : $0.valueArray[1]))
                    textFieldCell.setUnitsText(text: $0.optionName.rawValue == TextValues.weight ? TextValues.kg : TextValues.cm)
                    textFieldCell.customSwitch.isOn = $0.isShown
                    self.textFieldCells.append(textFieldCell)
                    
                    let optionCell = OptionCell()
                    optionCell.set(text: $0.optionName.rawValue)
                    optionCell.setButton(isActive: $0.isShown)
                    self.delegate?.cells.append(optionCell)
                }
                completion()
            case .failure(_):
                completion()
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
                if avatarImage != UIImage.profileAvatarPlaceholder {
                    vc.setBorder()
                }
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
                    let alertCoordinator = CustomAlertCoordinator(navigationController: navigationController, isSuccessAlert: true, messageText: TextValues.successSavedProfile, withButtons: false, containerHeight: Constants.emptyAlertHeight, image: UIImage.success)
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
                    let alertCoordinator = CustomAlertCoordinator(navigationController: navigationController, isSuccessAlert: true, messageText: TextValues.successSavedProfile, withButtons: false, containerHeight: Constants.emptyAlertHeight, image: UIImage.success)
                    alertCoordinator.start()
                case .failure(_):
                    vc.showAlert(vc: vc, error: .errorUpdatingUser)
                }
            }
        }
        
        isAvatarChanged = false
        saveButton.set(.appSecondary)
    }
    
    
    func deleteAccountButtonAction(navigationController: UINavigationController?) {
        guard let navigationController else { return }
        
        let deleteAccountCoordinator = DeleteAccountCoordinator(navigationController: navigationController)
        deleteAccountCoordinator.start()
    }
    
    
    func updateOptionTextFields(saveButton: CustomButton, navigationController: UINavigationController?) {
        guard let navigationController else { return }
        
        
        var textFieldsDic: [[String: Any]] = []
        
        textFieldCells.forEach { textFieldsDic.append([
            "optionName": $0.textField.titleLabel.text,
            "isShown": $0.customSwitch.isOn,
            "value": $0.textField.getText()
            ]
        ) }
        
        if isTableViewActive {
            FirebaseService.shared.updateOptionData(textFieldsDic: textFieldsDic) { [weak self] result in
                guard let self else { return }
                
                switch result {
                case .success(let success):
                    let alertCoordinator = CustomAlertCoordinator(navigationController: navigationController, isSuccessAlert: true, messageText: TextValues.successSavedProfile, withButtons: false, containerHeight: Constants.emptyAlertHeight, image: UIImage.success)
                    alertCoordinator.start()
                case .failure(let failure):
                    guard let delegate else { return }
                    self.delegate?.showAlert(vc: delegate, error: .errorUpdatingUser)
                }
            }
        }
        
        isTableViewActive = false
        saveButton.set(.appSecondary)
    }
    
    
    func addOptionsButtonAction(navigationController: UINavigationController?) {
        guard let navigationController else { return }
        
        let selectOptionsCoordinator = SelectOptionsCoordinator(navigationController: navigationController)
        selectOptionsCoordinator.delegate = delegate
        selectOptionsCoordinator.start()
    }
}

