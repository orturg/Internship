//
//  EmptyAlertCoordinator.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 22.07.2024.
//

import UIKit

final class EmptyAlertCoordinator: Coordinator {
    let navigationController: UINavigationController
    let messageText: String
    var alert: CustomAlertVC?
    
    
    init(navigationController: UINavigationController, messageText: String) {
        self.navigationController = navigationController
        self.messageText = messageText
    }
    
    func start() {
        let alert = EmptyCustomAlertVC(messageText: messageText)
        let alertVM = EmptyAlertViewModel()
        
        alert.vm = alertVM
        alert.vm?.coordinator = self
        
        navigationController.present(alert, animated: true)
    }
}
