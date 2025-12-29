//
//  RecoveryPassword.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 28/12/25.
//

import Foundation

struct RecoveryPassword: Equatable {
    let message: String
    let user: UserData
}

struct UserData: Equatable {
    let uuid: String
    let email: String
}
