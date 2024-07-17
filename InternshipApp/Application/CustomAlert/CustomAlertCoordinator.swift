//
//  CustomAlertCoordinator.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 17.07.2024.
//

import UIKit

final class CustomAlertCoordinator: Coordinator {
    let navigationController: UINavigationController
    let isSuccessAlert: Bool
    let messageText: String
    let resetPasswordVC: UIViewController
    var alert: CustomAlertVC?
    
    init(navigationController: UINavigationController, isSuccessAlert: Bool, messageText: String, resetPasswordVC: UIViewController) {
        self.navigationController = navigationController
        self.isSuccessAlert = isSuccessAlert
        self.messageText = messageText
        self.resetPasswordVC = resetPasswordVC
    }
    
    func start() {
        if isSuccessAlert {
            alert = CustomAlertVC(isSuccessAlert: true, messageText: TextValues.successResetMessage, resetPasswordVC: resetPasswordVC)
        } else {
            alert = CustomAlertVC(isSuccessAlert: false, messageText: TextValues.failedResetMessage, resetPasswordVC: resetPasswordVC)
        }
        guard let alert else { return }
        
        let alertVM = CustomAlertViewModel()
        alert.vm = alertVM
        alert.vm?.coordinator = self
        
        navigationController.present(alert, animated: true)
    }
}
