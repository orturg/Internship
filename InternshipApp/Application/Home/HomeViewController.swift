//
//  HomeViewController.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 29.06.2024.
//

import UIKit

class HomeViewController: BaseViewController {
    
    weak var homeCoordinator: HomeCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        title = "Home"
    }
}
