//
//  LoginUseCase.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 22/12/25.
//

import Foundation

final class LoginUseCase {
    private let authRepo: AuthRepository
    private let saveLoginSession: SaveLoginSessionUseCase
    
    init(authRepo: AuthRepository, saveLoginSession: SaveLoginSessionUseCase) {
        self.authRepo = authRepo
        self.saveLoginSession = saveLoginSession
    }
    
    func execute(username: String, password: String, time: Int?) async throws -> UserEntity {
        let result = try await authRepo.login(username: username, password: password, time: time)
        saveLoginSession.execute(user: result.user, token: result.token)
        return result.user
    }
}
