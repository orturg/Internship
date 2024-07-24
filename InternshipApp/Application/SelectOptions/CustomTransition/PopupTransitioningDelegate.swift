//
//  PopupTransitioningDelegate.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 24.07.2024.
//

import UIKit

class PopupTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        return PopupTransitioningPresentationController(presentedViewController: presented,
                                                        presenting: presenting)
    }
}
