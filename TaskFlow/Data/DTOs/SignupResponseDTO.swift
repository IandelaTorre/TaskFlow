//
//  LogupResponseDTO.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 28/12/25.
//

import Foundation

struct SignupResponseDTO: Decodable {
    let data: SignupResponseDataDTO
}

struct SignupResponseDataDTO: Decodable {
    let id: Int
    let uuid: String
    let email: String
    let name: String?
    let lastName: String?
    let secondLastName: String?
    let userCode: String
    let roleId: Int
    let enabled: Bool
    let createdAt: Date
    let updatedAt: Date
}
