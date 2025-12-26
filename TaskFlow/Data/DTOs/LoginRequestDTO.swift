//
//  LoginRequestDTO.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 22/12/25.
//

import Foundation

struct LoginRequestDTO: Codable {
    let email: String
    let password: String
    let expirationDays: Int?
}
