//
//  UserEntity.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 22/12/25.
//

import Foundation

struct UserEntity: Equatable {
    let id: Int
    let email: String
    let name: String?
    let lastName: String?
    let secondLastName: String?
    let createdAt: Date
    let updatedAt: Date
    let enabled: Bool
    let rolId: Int
    let uuid: String
    let userCode: String
    let role: UserRole?
    
}

struct UserRole: Equatable {
    let id: Int
    let name: String
    let visualName: String
    let createdAt: Date

}
