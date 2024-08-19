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
    var withButtons: Bool
    var containerHeight: CGFloat
    var image: UIImage?
    
    weak var delegate: ResetPasswordVCDelegate?
    
    init(navigationController: UINavigationController, isSuccessAlert: Bool, messageText: String, withButtons: Bool, containerHeight: CGFloat, image: UIImage?) {
        self.navigationController = navigationController
        self.isSuccessAlert = isSuccessAlert
        self.messageText = messageText
        self.withButtons = withButtons
        self.containerHeight = containerHeight
        self.image = image
    }
    
    func start() {
        if withButtons {
            if isSuccessAlert {
                alert = CustomAlertVC(isSuccessAlert: true, messageText: messageText, withButtons: true, containerHeight: containerHeight)
                
            } else {
                alert = CustomAlertVC(isSuccessAlert: false, messageText: messageText, withButtons: true, containerHeight: containerHeight)
                alert?.delegate = delegate
            }
        } else {
            alert = CustomAlertVC(isSuccessAlert: true, messageText: messageText, withButtons: false, containerHeight: containerHeight)
        }
        guard let alert else { return }
        
        let alertVM = CustomAlertViewModel()
        alert.vm = alertVM
        alert.vm?.coordinator = self
        
        if let image { 
            alert.setImageView(image: image)
        }
        
        navigationController.present(alert, animated: true)
    }
}
