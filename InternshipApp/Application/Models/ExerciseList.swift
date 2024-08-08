//
//  ExerciseList.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 06.08.2024.
//

import Foundation

struct ExerciseList: Codable {
    
    let muscleName: String
    let exercisesList: [Exercise]
}

struct Exercise: Codable {
    let name: String
    let imageIcon: String
    let exerciseImage: String
    let descriptions: String
    let exerciseType: ExerciseType.RawValue
    let equipment: Equipment.RawValue
    let level: Level.RawValue
}

enum ExerciseType: String, Codable {
    case bodybuilding = "Bodybuilding"
    case powerlifting = "Powerlifting"
}

enum Equipment: String, Codable {
    case dumbbell = "Dumbbells"
    case barbell = "Barbell"
    case cablemachine = "Cable Machine"
    case bodyweight = "Bodyweight"
}

enum Level: String, Codable {
    case beginner = "Beginner"
    case intermediate = "Intermediate"
    case advanced = "Advanced"
}
