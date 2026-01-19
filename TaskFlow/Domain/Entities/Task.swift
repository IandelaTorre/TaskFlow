//
//  Task.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 18/01/26.
//

import Foundation

struct UserTask: Equatable {
    let title: String
    let description: String?
    let status: UserTaskStatus
    let assignedTo: UserAssigned
    let assignedBy: UserAssigned
    let assignedAt: Date
    let createdAt: Date
    let updatedAt: Date
    let isEnabled: Bool
}

struct UserTaskStatus: Equatable {
    let id: String
    let code: String
    let name: String
}

struct UserAssigned: Equatable {
    let id: String
    let userCode: String
    let name: String
    let lastName: String
}
