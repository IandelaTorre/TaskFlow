//
//  HomeCoordinator.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 19/11/25.
//

import UIKit

final class HomeCoordinator {
    private let window: UIWindow
    private let diContainer: DIContainer

    init(window: UIWindow, diContainer: DIContainer) {
        self.window = window
        self.diContainer = diContainer
    }

    @MainActor func start() {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)

        guard let navController = storyboard.instantiateViewController(withIdentifier: "HomeNavController") as? UINavigationController else {
            fatalError("No se encontró HomeNavigationController en el storyboard Home")
        }

        guard let homeVC = navController.viewControllers.first as? HomeViewController else {
            fatalError("No se encontró HomeViewController como raíz del NavigationController")
        }

        homeVC.viewModel = diContainer.home.makeHomeViewModel()

        window.rootViewController = navController
        window.makeKeyAndVisible()
    }
}

