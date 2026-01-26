//
//  CreateTaskUseCase.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 25/01/26.
//

import Foundation

final class CreateTaskUseCase {
    private let taskRepository: TaskRepository
    
    init(taskRepository: TaskRepository) {
        self.taskRepository = taskRepository
    }
    
    func execute(title: String, description: String, statusId: Int, assignedTo: String, assignedBy: String) async throws -> UserTask {
        let result = try await taskRepository.createTask(title: title, description: description, statusId: statusId, assignedTo: assignedTo, assignedBy: assignedBy)
        return result
    }
}
