//
//  UpdateTaskRequestDTO.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 26/01/26.
//

import Foundation

struct UpdateTaskRequestDTO: Codable {
    let title: String?
    let description: String?
    let statusId: Int?
    let assignedToCode: String?
    let assignedByCode: String?
    let isActive: Bool?
}
