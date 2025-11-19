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

    init(window: UIWindow, diContainer: DIContainer) {
        self.window = window
        self.diContainer = diContainer
    }

    @MainActor func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let userLogged = true
        let rootController: UINavigationController
        if userLogged {
            guard let homeNav = storyboard.instantiateViewController(withIdentifier: "HomeNavigationController") as? UINavigationController else {
                    fatalError("No se encontró HomeNavigationController en el Storyboard")
                }
                        
            if let homeVC = homeNav.viewControllers.first as? TaskFlowViewController {
                    homeVC.viewModel = diContainer.makeTaskFlowViewModel()
                }
                        
            rootController = homeNav
        } else {
            guard let loginNav = storyboard.instantiateViewController(withIdentifier: "LoginNavigationController") as? UINavigationController else {
                    fatalError("No se encontró LoginNavigationController en el Storyboard")
            }
            rootController = loginNav
        }
        
        window.rootViewController = rootController
        window.makeKeyAndVisible()
    }
}
