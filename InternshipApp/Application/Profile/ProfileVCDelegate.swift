//
//  ProfileVCDelegate.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 24.07.2024.
//

import UIKit

protocol ProfileVCDelegate: UIViewController {
    var cells: [OptionCell] { get set }
    func add(_ cell: OptionCell)
    func remove(_ cell: OptionCell)
    func showAlert(vc: UIViewController, error: Error)
}
