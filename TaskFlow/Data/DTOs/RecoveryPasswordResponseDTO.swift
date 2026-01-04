//
//  RecoveryPasswordResponseDTO.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 28/12/25.
//

import Foundation

struct RecoveryPasswordResponseDTO: Decodable {
    let data: DataResponseDTO
}

struct DataResponseDTO: Decodable {
    let message: String
    let user: UserRPDTO
}

struct UserRPDTO: Decodable {
    let uuid: String
    let email: String
}
