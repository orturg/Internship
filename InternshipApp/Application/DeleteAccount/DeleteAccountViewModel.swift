//
//  DeleteAccountViewModel.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 02.08.2024.
//

import UIKit

final class DeleteAccountViewModel {
    weak var coordinator: DeleteAccountCoordinator?
    
    func isValidEmail(text: String?) -> Bool {
        let currentUserEmail = FirebaseService.shared.getCurrentUserEmail()
        
        guard text == currentUserEmail else {
            return false
        }
        
        return true
    }
    
    
    func deleteButtonAction(navigationController: UINavigationController?) {
        guard let navigationController else { return }
        
        let deleteAlertCoordinator = DeleteAccountAlertCoordinator(navigationController: navigationController, messageText: TextValues.deleteAccountAlertText, containerHeight: Constants.deleteAlertContainerHeight)
        deleteAlertCoordinator.start()
    }
}
