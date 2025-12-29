//
//  SignupUseCase.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 28/12/25.
//

import Foundation

final class SignupUseCase {
    private let authRepo: AuthRepository
    
    init(authRepo: AuthRepository) {
        self.authRepo = authRepo
    }
    
    func execute(name: String, lastName: String, email: String, password: String) async throws -> UserEntity {
        let result = try await authRepo.signup(name: name, lastName: lastName, email: email, password: password)
        print("result (SignupUseCase): \(result)")
        return result
    }
}
