//
//  CustomAlertViewModel.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 17.07.2024.
//

import UIKit

final class CustomAlertViewModel {
    weak var coordinator: CustomAlertCoordinator?
    
    func okButtonAction(alertVC: UIViewController) {
        alertVC.dismiss(animated: true)
    }
    
    
    func cancelButtonAction(alertVC: UIViewController, resetPasswordVC: UIViewController) {
        alertVC.dismiss(animated: true)
        resetPasswordVC.navigationController?.popViewController(animated: true)
    }
    
    
    func handleTapOutside(sender: UITapGestureRecognizer, view: UIView, containerView: ContainerView, vc: UIViewController) {
        let location = sender.location(in: view)
        if !containerView.frame.contains(location) {
            vc.dismiss(animated: true)
        }
    }
}
