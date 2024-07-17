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
    var alert: CustomAlertVC?
    
    weak var delegate: ResetPasswordVCDelegate?
    
    init(navigationController: UINavigationController, isSuccessAlert: Bool, messageText: String) {
        self.navigationController = navigationController
        self.isSuccessAlert = isSuccessAlert
        self.messageText = messageText
    }
    
    func start() {
        if isSuccessAlert {
            alert = CustomAlertVC(isSuccessAlert: true, messageText: TextValues.successResetMessage)
        } else {
            alert = CustomAlertVC(isSuccessAlert: false, messageText: TextValues.failedResetMessage)
            alert?.delegate = delegate
        }
        guard let alert else { return }
        
        let alertVM = CustomAlertViewModel()
        alert.vm = alertVM
        alert.vm?.coordinator = self
        
        navigationController.present(alert, animated: true)
    }
}
