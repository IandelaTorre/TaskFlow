//
//  HomeContainer.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 18/11/25.
//

import Foundation

final class HomeContainer {
    private unowned let di: DIContainer
    
    init(di: DIContainer) {
        self.di = di
    }
    
    @MainActor func makeHomeViewModel() -> HomeViewModel {
        return HomeViewModel(createTaskUseCase: CreateTaskUseCase(taskRepository: di.taskRepository), getTasksUseCase: GetTasksUseCase(taskRepository: di.taskRepository), getMyTasksUseCase: GetMyTasksUseCase(taskRepository: di.taskRepository), getTaskUseCase: GetTaskUseCase(taskRepository: di.taskRepository), updateTaskUseCase: UpdateTaskUseCase(taskRespository: di.taskRepository))
    }
}
