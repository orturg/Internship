//
//  DeleteAccountAlertCoordinator.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 02.08.2024.
//

import UIKit

final class DeleteAccountAlertCoordinator {
    let navigationController: UINavigationController
    let messageText: String
    var containerHeight: CGFloat
    
    init(navigationController: UINavigationController, messageText: String, containerHeight: CGFloat) {
        self.navigationController = navigationController
        self.messageText = messageText
        self.containerHeight = containerHeight
    }
    
    func start() {
        let alertVC = DeleteAccountAlertViewController(messageText: messageText, containerHeight: containerHeight)
        let alertVM = DeleteAccountAlertViewModel()
        
        alertVC.vm = alertVM
        alertVC.vm?.coordinator = self
        
        navigationController.present(alertVC, animated: true)
    }
}
