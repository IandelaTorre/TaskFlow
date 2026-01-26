//
//  GetTaskUseCase.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 26/01/26.
//

import Foundation

final class GetTaskUseCase {
    private let taskRepository: TaskRepository
    
    init(taskRepository: TaskRepository) {
        self.taskRepository = taskRepository
    }
    
    func execute(taskId: Int) async throws -> UserTask {
        let result = try await taskRepository.getTask(taskId: taskId)
        return result
    }
}
