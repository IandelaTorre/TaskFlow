//
//  CreateTaskRequestDTO.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 21/01/26.
//

import Foundation


struct CreateTaskRequestDTO: Codable {
    let title: String
    let description: String
    let statusId: Int
    let assignedToCode: String 
    let assignedByCode: String
}
