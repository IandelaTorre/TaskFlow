//
//  UserResponseDTO.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 22/12/25.
//

import Foundation

struct LoginResponseDTO: Decodable {
    let data: UserResponseDTO
}

struct UserResponseDTO: Decodable {
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
    let role: UserResponseRoles?
    let accessToken: String
    
    /*enum CodingKeys: String, CodingKey {
        case id
        case name
        case lastName
        case secondLastName
        case email
        case password
        case createdAt
        case updatedAt
        case enabled
        case rolId
        case uuid
        case userCode = "user_code"
        case role
    }*/
}

struct UserResponseRoles: Decodable {
    let id: Int
    let uuid: String
    let name: String
    let visualName: String
    let enabled: Bool
    let createdAt: Date
    
}
