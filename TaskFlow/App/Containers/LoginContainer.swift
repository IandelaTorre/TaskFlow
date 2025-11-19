//
//  LoginContainer.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 18/11/25.
//

import Foundation

final class LoginContainer {
    @MainActor func makeLoginViewModel() -> LoginViewModel {
        return LoginViewModel()
    }
}
