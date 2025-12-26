//
//  AuthRepository.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 22/12/25.
//

import Foundation

protocol AuthRepository {
    func login(username: String, password: String, time: Int?) async throws -> (user: UserEntity, token: String?)
}
