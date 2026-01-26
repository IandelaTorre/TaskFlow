//
//  CreateTaskResponseDTO.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 25/01/26.
//

import Foundation

struct CreateTaskResponseDTO: Decodable {
    let data: CreateTaskDataDTO
}

struct CreateTaskDataDTO: Decodable {
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
}
