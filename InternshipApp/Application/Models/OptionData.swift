//
//  OptionData.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 25.07.2024.
//

import Foundation
import FirebaseFirestoreInternal

struct OptionData: Codable {
    var isShown: Bool
    var optionName: OptionDataName
    var valueArray: [Int]
    var changedValue: Int
    var dateArray: [Double]
}
