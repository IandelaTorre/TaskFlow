//
//  LoginContainer.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 18/11/25.
//

import Foundation

final class LoginContainer {
    private unowned let di: DIContainer
    
    init(di: DIContainer) {
        self.di = di
    }
    
    func makeLoginUseCase() -> LoginUseCase {
        let saveSession = SaveLoginSessionUseCase(localRepository: di.localRepository)
        return LoginUseCase(authRepo: di.authRepository, saveLoginSession: saveSession)
    }
    
    @MainActor func makeLoginViewModel() -> LoginViewModel {
        return LoginViewModel(loginUseCase: makeLoginUseCase())
    }
}
