//
//  RecoveryPasswordRequestDTO.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 28/12/25.
//

import Foundation

struct RecoveryPasswordRequestDTO: Codable {
    let email: String
    let recoveryCode: String
    let newPassword: String    
}
