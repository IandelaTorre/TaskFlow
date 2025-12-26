//
//  AppCoordinator.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 18/11/25.
//

import UIKit

final class AppCoordinator {
    private let window: UIWindow
    private let diContainer: DIContainer
    
    private var homeCoordinator: HomeCoordinator?
    private var loginCoordinator: LoginCoordinator?

    init(window: UIWindow, diContainer: DIContainer) {
        self.window = window
        self.diContainer = diContainer
    }

    @MainActor func start() {
        if CoreDataHelper.shared.getIsLoggedIn() {
            showHome()
        } else {
            showLogin()
        }
    }
    
    @MainActor private func showHome() {
        let homeCoordinator = HomeCoordinator(window: window, diContainer: diContainer)
        self.homeCoordinator = homeCoordinator
        homeCoordinator.onLogout = { [weak self] in
            CoreDataHelper.shared.clearSession()
            self?.showLogin()
        }
        homeCoordinator.start()
    }

    @MainActor private func showLogin() {
        let loginCoordinator = LoginCoordinator(window: window, diContainer: diContainer)
        self.loginCoordinator = loginCoordinator
        loginCoordinator.onLoginSuccess = { [weak self] in
            self?.showHome()
        }
        
        loginCoordinator.start()
    }
}
