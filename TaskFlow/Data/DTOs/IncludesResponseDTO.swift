//
//  IncludesResponseDTO.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 25/01/26.
//

import Foundation


struct TaskStatusResponseDTO: Decodable {
    let statusId: Int
    let code: String
    let name: String
    let description: String
    let isActive: Bool
}

struct AssignedUserResponseDto: Decodable {
    let id: Int
    let uuid: UUID
    let email: String
    let name: String
    let lastName: String
    let secondLastName: String
    let userCode: String
    let roleId: Int
    let enabled: Bool
}
