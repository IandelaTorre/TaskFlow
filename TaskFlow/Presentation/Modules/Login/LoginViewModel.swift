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
    
    @Published var password: String? = nil
    @Published var reEnterPassword: String? = nil
    @Published var enabledRecoveryPassButton: Bool? = nil
    
    private var cancellables = Set<AnyCancellable>()
    private let validator: InputValidator = LoginInputValidator()
    
    init(loginUseCase: LoginUseCase, signupUseCase: SignupUseCase, recoveryPassUseCase: RecoveryPasswordUseCase) {
        self.loginUseCase = loginUseCase
        self.signupUseCase = signupUseCase
        self.recoveryPassUseCase = recoveryPassUseCase
        
        Publishers.CombineLatest($password, $reEnterPassword)
            .debounce(for: .milliseconds(200), scheduler: RunLoop.main)
            .sink { [weak self] pass1, pass2 in
                guard let self = self else { return
                }
                let p1 = pass1 ?? ""
                let p2 = pass2 ?? ""
                if p1.isEmpty || p2.isEmpty {
                    self.errorMessage = ""
                    self.enabledRecoveryPassButton = false
                    return
                }
                if p1 == p2 {
                    self.errorMessage = nil
                    self.enabledRecoveryPassButton = true
                } else {
                    self.errorMessage = "Las contraseñas no coinciden"
                    self.enabledRecoveryPassButton = false
                }
            }
            .store(in: &cancellables)
    }
    
    func login(username: String, password: String) async -> Bool {
        isLoading = true
        defer { isLoading = false }
        
        if let error = validator.validateAll([(.email, username), (.password, password)])?.message {
            errorMessage = error
            return false
        }
        
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
        
        if let error = validator.validateAll([(.name, name), (.lastName, lastName), (.email, email), (.password, password)])?.message {
            errorMessage = error
            return false
        }
        
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
        
        if let error = validator.validateAll([(.email, email), (.password, newPassword)])?.message {
            errorMessage = error
            return false
        }
        
        do {
            _ = try await recoveryPassUseCase.execute(email: email, recoveryCode: recoveryCode, newPassword: newPassword)
            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }
}
