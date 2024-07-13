//
//  ViewController+Ext.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 13.07.2024.
//

import UIKit

extension UIViewController {
    func showAlert(vc: UIViewController, error: DataBaseError) {
        let alert = UIAlertController(title: TextValues.error, message: error.rawValue, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        vc.present(alert, animated: true)
    }
}
