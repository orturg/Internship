//
//  DataBaseErrors.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 11.07.2024.
//

import Foundation

enum DataBaseError: String, Error {
    case errorCreatingUser = "Error occurred creating user. Please try again later."
    case errorUpdatingUser = "Error occurred updating user. Please try again."
    case errorGettingUser = "Error occurred getting user. Please try again."
    case errorSigningIn = "Error occurred signing in. Please try again."
}
