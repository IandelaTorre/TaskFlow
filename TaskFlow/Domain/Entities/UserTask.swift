//
//  Task.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 18/01/26.
//

import Foundation

struct UserTask: Equatable {
    let id: Int
    let title: String
    let description: String
    let statusId: Int
    let assignedToCode: String
    let assignedByCode: String
    let assignedAt: Date
    let createdAt: Date
    let updatedAt: Date
    let isActive: Bool
    let assignedBy: UserAssigned?
    let assignedTo: UserAssigned?
    let status: UserTaskStatus?
}

struct UserTaskStatus: Equatable {
    let statusId: Int
    let code: String
    let name: String
    let description: String
    let isActive: Bool
}

struct UserAssigned: Equatable {
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
