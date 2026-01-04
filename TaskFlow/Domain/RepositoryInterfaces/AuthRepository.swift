//
//  AuthRepository.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 22/12/25.
//

import Foundation

protocol AuthRepository {
    func login(username: String, password: String, time: Int?) async throws -> (user: UserEntity, token: String?)
    
    func signup(name: String, lastName: String, email: String, password: String) async throws -> UserEntity
    
    func recoveryPassword(email: String, recoveryCode: String, newPassword: String) async throws -> RecoveryPassword
}
