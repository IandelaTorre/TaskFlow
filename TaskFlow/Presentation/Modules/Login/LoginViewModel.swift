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
    
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String? = ""
    
    init(loginUseCase: LoginUseCase) {
        self.loginUseCase = loginUseCase
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
}
