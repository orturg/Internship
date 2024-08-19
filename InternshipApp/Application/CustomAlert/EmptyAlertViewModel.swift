//
//  EmptyAlertViewModel.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 22.07.2024.
//

import Foundation

final class EmptyAlertViewModel {
    weak var coordinator: EmptyAlertCoordinator?
    
    func okButtonAction(alertVC: CustomAlertVC) {
        alertVC.dismiss(animated: true)
    }
    
    
    func cancelButtonAction(alertVC: CustomAlertVC) {
        alertVC.dismiss(animated: true) {
            alertVC.dimissVC()
        }
    }
}
