//
//  OptionData.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 25.07.2024.
//

import Foundation

struct OptionData: Codable {
    var isShown: Bool
    var optionName: OptionDataName
//    var valueArray: [Double?]
//    var changedValue: Int?
//    var dateArray: [Int]
    var value: Int
}
