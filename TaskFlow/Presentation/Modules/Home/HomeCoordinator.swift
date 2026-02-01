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
    
    var onLogout: (() -> Void)?

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
        homeVC.onLogout = { [weak self] in
            self?.onLogout?()
        }
        homeVC.onTapDetailTask = { [weak self] task in
            self?.showDetailTask(in: navController, task: task)
        }
        
        homeVC.onTapAddTask = { [weak self] in
            self?.showAddTask(in: navController)
        }

        window.rootViewController = navController
        window.makeKeyAndVisible()
    }
    
    @MainActor private func showDetailTask(in navController: UINavigationController, task userTask: UserTask) {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        guard let detTaskVC = storyboard.instantiateViewController(withIdentifier: "DetailTaskViewController") as? DetailTaskViewController else {
            fatalError("No se encontró DetailTaskViewController")
        }
        detTaskVC.onSuccess = { [weak self] in
            self?.start()
        }
        detTaskVC.viewModel = diContainer.home.makeHomeViewModel()
        detTaskVC.task = userTask
        navController.pushViewController(detTaskVC, animated: true)
    }

    
    @MainActor private func showAddTask(in navController: UINavigationController) {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        guard let addTaskVC = storyboard.instantiateViewController(withIdentifier: "AddTaskViewController") as? AddTaskViewController else {
            fatalError("No se encontró AddTaskViewController")
        }
        addTaskVC.onSuccess = { [weak self] in
            self?.start()
        }
        addTaskVC.viewModel = diContainer.home.makeHomeViewModel()
        navController.pushViewController(addTaskVC, animated: true)
    }

}

