//
//  GetTasksResponseDTO.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 25/01/26.
//

import Foundation

struct TasksResponseDTO: Decodable {
    let data: [TasksResponseDataDTO]
}

struct TaskResponseDTO: Decodable {
    let data: TasksResponseDataDTO
}

struct TasksResponseDataDTO: Decodable {
    let id: Int
    let title: String
    let description: String
    let statusId: Int
    let assignedByCode: String
    let assignedAt: Date
    let assignedToCode: String
    let createdAt: Date
    let updatedAt: Date
    let isActive: Bool
    let assignedBy: AssignedUserResponseDto?
    let assignedTo: AssignedUserResponseDto?
    let status: TaskStatusResponseDTO?
}
