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
    weak var deleteAccountVCDelegate: DeleteAccountVCDelegate?
    
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
        deleteAccountVCDelegate?.isDeleteButtonActive = true
    }
    
    
    private func deleteUser() {
        deleteAccountVCDelegate?.isDeleteButtonActive = false
        FirebaseService.shared.deleteAuthenticatedUser()
        FirebaseService.shared.deleteUserFromFirestore { [weak self] result in
            guard let self else { return }
            guard let delegate else { return }
            
            switch result {
            case .success(_): break
            case .failure(let error):
                delegate.dismissVC()
                delegate.showAlert(vc: delegate, error: error)
                deleteAccountVCDelegate?.isDeleteButtonActive = true
            }
        }
    }
}
