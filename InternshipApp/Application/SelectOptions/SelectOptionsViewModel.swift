//
//  SelectOptionsViewModel.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 23.07.2024.
//

import UIKit

class SelectOptionsViewModel {
    weak var coordinator: SelectOptionsCoordinator?
    weak var delegate: ProfileVCDelegate?
    var tableView: UITableView?
    
    func cancelButtonAction(vc: UIViewController) {
        vc.dismiss(animated: true)
    }
    
    
    func selectButtonAction(vc: UIViewController) {
        guard let delegate else { return }
        guard let tableView else { return }
        
        vc.dismiss(animated: true)
        
        for i in 0..<OptionDataName.allCases.count {
            let indexPath = IndexPath(row: i, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) as? OptionCell, cell.button.isActive {
                if delegate.cells.allSatisfy({ $0.optionLabel.text != cell.optionLabel.text }) {
                    delegate.add(cell)
                }
            }
            
            if let cell = tableView.cellForRow(at: indexPath) as? OptionCell, !cell.button.isActive {
                delegate.remove(cell)
            }
            
        }
        
        self.delegate?.viewWillAppear(true)
    }
}

