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

        window.rootViewController = navController
        window.makeKeyAndVisible()
    }
}

