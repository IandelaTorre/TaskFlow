//
//  GetTasksUseCase.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 25/01/26.
//

import Foundation

final class GetTasksUseCase {
    private let taskRepository: TaskRepository
    
    init(taskRepository: TaskRepository) {
        self.taskRepository = taskRepository
    }
    
    func execute() async throws -> [UserTask] {
        let result = try await taskRepository.getTasks()
        return result
    }
}
