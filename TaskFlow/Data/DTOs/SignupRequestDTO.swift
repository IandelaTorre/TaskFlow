//
//  LogupRequestDTO.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 28/12/25.
//

import Foundation


struct SignupRequestDTO: Codable {
    let name: String
    let lastName: String
    let email: String
    let password: String
}
