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
    case errorResetingPassword = "Error occurred reseting password. Please try again."
    case errorDeletingUser = "Error occurred deleting user. Please try again."
}
