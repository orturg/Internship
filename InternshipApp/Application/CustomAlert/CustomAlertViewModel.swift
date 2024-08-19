//
//  CustomAlertViewModel.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 17.07.2024.
//

import UIKit

final class CustomAlertViewModel {
    weak var coordinator: CustomAlertCoordinator?
    
    func okButtonAction(alertVC: CustomAlertVC) {
        alertVC.dismiss(animated: true)
    }
    
    
    func cancelButtonAction(alertVC: CustomAlertVC) {
        alertVC.dismiss(animated: true) {
            alertVC.dimissVC()
        }
    }
}
