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
    
    
    //    func getData(vc: ProfileViewController) {
    //        FirebaseService.shared.getOptionData { [weak self] result in
    //            guard let self else { return }
    //            switch result {
    //            case .success(let options):
    //
    //                options?.forEach {
    //
    //                    let textFieldCell = TextFieldCell()
    //                    textFieldCell.setTextFieldTitle(text: $0.optionName.rawValue)
    //                    textFieldCell.setTextFieldText(text: String($0.value))
    //                    textFieldCell.setUnitsText(text: $0.optionName.rawValue == "Weight" ? "kg" : "cm")
    //                    textFieldCell.customSwitch.isOn = $0.isShown
    //                    self.textFieldCells.append(textFieldCell)
    //
    //                    let optionCell = OptionCell()
    //                    optionCell.set(text: $0.optionName.rawValue)
    //                    optionCell.setButton(isActive: $0.isShown)
    //                    self.delegate?.add(optionCell)
    //                }
    //                vc.layoutTableView()
    //
    //            case .failure(_):
    //                break
    //            }
    //
    //
    //        }
    //    }
    
    
    func getData(vc: ProfileViewController, completion: @escaping () -> Void) {
        FirebaseService.shared.getOptionData { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let options):
                options?.forEach {
                    let textFieldCell = TextFieldCell()
                    textFieldCell.setTextFieldTitle(text: $0.optionName.rawValue)
                    textFieldCell.setTextFieldText(text: String($0.value))
                    textFieldCell.setUnitsText(text: $0.optionName.rawValue == "Weight" ? "kg" : "cm")
                    textFieldCell.customSwitch.isOn = $0.isShown
                    self.textFieldCells.append(textFieldCell)
                    
                    let optionCell = OptionCell()
                    optionCell.set(text: $0.optionName.rawValue)
                    optionCell.setButton(isActive: $0.isShown)
                    //                    self.delegate?.cells.append(optionCell)
                    vc.cells.append(optionCell)
                }
                print("dcv\(delegate?.cells.count)")
                completion()
            case .failure(_):
                completion()
            }
        }
    }
    
    
    func updateTextFields(with cells: [TextFieldCell]) {
        for (index, cell) in cells.enumerated() {
            textFieldCells[index].setTextFieldText(text: cell.textField.getText())
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
    
    
    func updateOptionTextFields(saveButton: CustomButton, textFields: [TextFieldCell], vc: UIViewController, navigationController: UINavigationController?) {
        guard let navigationController else { return }
        
        if isTableViewActive {
            textFields.forEach { print($0.textField.textField.text) }
            FirebaseService.shared.updateOptionData(textFields: textFields) { result in
                switch result {
                case .success(let success):
                    let alertCoordinator = CustomAlertCoordinator(navigationController: navigationController, isSuccessAlert: true, messageText: TextValues.successSavedProfile, withButtons: false, containerHeight: Constants.emptyAlertHeight, image: UIImage.success)
                    alertCoordinator.start()
                case .failure(let failure):
                    vc.showAlert(vc: vc, error: .errorUpdatingUser)
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
    
    
    //    func updateOptionsAction(navigationController: UINavigationController?) {
    //        guard let navigationController else { return }
    //
    //        let alertCoordinator = EmptyAlertCoordinator(navigationController: navigationController, messageText: TextValues.successSavedProfile)
    //        alertCoordinator.start()
    //    }
}

