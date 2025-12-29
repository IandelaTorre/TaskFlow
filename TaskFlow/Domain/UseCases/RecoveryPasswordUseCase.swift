//
//  RecoveryPasswordUseCase.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 28/12/25.
//

import Foundation

final class RecoveryPasswordUseCase {
    private let authRepo: AuthRepository
    
    init(authRepo: AuthRepository) {
        self.authRepo = authRepo
    }
    
    func execute(email: String, recoveryCode: String, newPassword: String) async throws -> RecoveryPassword {
        let result = try await authRepo.recoveryPassword(email: email, recoveryCode: recoveryCode, newPassword: newPassword)
        return result
    }
}
