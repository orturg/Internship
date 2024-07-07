//
//  HomeViewModel.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 29.06.2024.
//

import Foundation

class HomeViewModel {
    weak var homeCoordinator: HomeCoordinator?
    var titleText: String?
    var isMan: Bool
    
    init(titleText: String?, isMan: Bool) {
        self.titleText = titleText
        self.isMan = isMan
    }
}
