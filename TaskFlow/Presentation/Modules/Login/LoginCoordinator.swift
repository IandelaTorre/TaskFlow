//
//  LoginCoordinator.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 19/11/25.
//

import UIKit

final class LoginCoordinator {
    private let window: UIWindow
    private let diContainer: DIContainer
    
    var onLoginSuccess: (() -> Void)?

    init(window: UIWindow, diContainer: DIContainer) {
        self.window = window
        self.diContainer = diContainer
    }

    @MainActor func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        guard let navController = storyboard.instantiateViewController(withIdentifier: "LoginNavController") as? UINavigationController else {
            fatalError("No se encontró LoginNavigationController en el storyboard Login")
        }

        guard let loginVC = navController.viewControllers.first as? LoginViewController else {
            fatalError("No se encontró LoginViewController como raíz del NavigationController")
        }

        loginVC.viewModel = diContainer.login.makeLoginViewModel()
        
        loginVC.onLoginSuccess = { [weak self] in
            CoreDataHelper.shared.setIsLoggedIn(true)
            self?.onLoginSuccess?()
        }
        
        loginVC.onSignupTapped = { [weak self, weak navController] in
            guard let self, let navController else { return }
            self.showSignup(in: navController)
        }
        
        loginVC.onRecoveryTapped = { [weak self, weak navController] in
            guard let self, let navController else { return }
            self.showRecoveryPass(in: navController)
        }

        window.rootViewController = navController
        window.makeKeyAndVisible()
    }
    
    @MainActor private func showSignup(in navController: UINavigationController) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let signupVC = storyboard.instantiateViewController(withIdentifier: "SignupViewController") as? SignupViewController else {
            fatalError("No se encontró SignupViewController")
        }
        signupVC.viewModel = diContainer.login.makeLoginViewModel()
        navController.pushViewController(signupVC, animated: true)
    }
    
    @MainActor private func showRecoveryPass(in navController: UINavigationController) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let recoveryVC = storyboard.instantiateViewController(withIdentifier: "RecoveryPasswordViewController") as? RecoveryPasswordViewController else {
            fatalError("No se encontró RecoveryPasswordViewController")
        }
        recoveryVC.viewModel = diContainer.login.makeLoginViewModel()
        navController.pushViewController(recoveryVC, animated: true)
    }
}

