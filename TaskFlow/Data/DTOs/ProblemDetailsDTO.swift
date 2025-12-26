//
//  ProblemDetailsDTO.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 24/12/25.
//

import Foundation

struct ProblemDetailsDTO: Decodable {
    let type: String?
    let title: String?
    let status: Int?
    let detail: String?
    let instance: String?
}
