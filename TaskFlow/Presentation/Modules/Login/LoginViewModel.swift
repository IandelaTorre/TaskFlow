//
//  TaskFlowViewModel.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 18/11/25.
//

import Foundation
import Combine


class LoginViewModel {
    private let loginUseCase: LoginUseCase
    private let signupUseCase: SignupUseCase
    private let recoveryPassUseCase: RecoveryPasswordUseCase
    
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String? = ""
    
    init(loginUseCase: LoginUseCase, signupUseCase: SignupUseCase, recoveryPassUseCase: RecoveryPasswordUseCase) {
        self.loginUseCase = loginUseCase
        self.signupUseCase = signupUseCase
        self.recoveryPassUseCase = recoveryPassUseCase
    }
    
    func login(username: String, password: String) async -> Bool {
        isLoading = true
        defer { isLoading = false }
        
        do {
            _ = try await loginUseCase.execute(username: username, password: password, time: 1)
            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }
    
    func signup(name: String, lastName: String, email: String, password: String) async -> Bool {
        isLoading = true
        defer { isLoading = false }
        
        do {
            _ = try await signupUseCase.execute(name: name, lastName: lastName, email: email, password: password)
            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }
    
    func recoveryPassword(email: String, recoveryCode: String, newPassword: String) async -> Bool {
        isLoading = true
        defer { isLoading = false }
        do {
            _ = try await recoveryPassUseCase.execute(email: email, recoveryCode: recoveryCode, newPassword: newPassword)
            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }
}
