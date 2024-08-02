//
//  DeleteAccountAlertViewModel.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 02.08.2024.
//

import UIKit

final class DeleteAccountAlertViewModel {
    weak var coordinator: DeleteAccountAlertCoordinator?
    weak var delegate: DeleteAccountAlertDelegate?
    
    func deleteButtonAction() {
        deleteUser()
        delegate?.dismissVC()
        resetToInitialScreen()
    }
    
    
    private func resetToInitialScreen() {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = scene.delegate as? SceneDelegate else {
            return
        }
        sceneDelegate.resetToInitialScreen()
    }
    
    
    func cancelButtonAction() {
        delegate?.dismissVC()
    }
    
    
    private func deleteUser() {
        FirebaseService.shared.deleteAuthenticatedUser()
        FirebaseService.shared.deleteUserFromFirestore()
    }
}
