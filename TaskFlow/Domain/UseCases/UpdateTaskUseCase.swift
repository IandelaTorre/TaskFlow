//
//  UpdateTaskUseCase.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 26/01/26.
//

import Foundation

final class UpdateTaskUseCase {
    private let taskRespository: TaskRepository
    
    init(taskRespository: TaskRepository) {
        self.taskRespository = taskRespository
    }
    
    func execute(taskId: Int, title: String?, description: String?, statusId: Int?, assignedToCode: String?, assignedByCode: String?, isActive: Bool?) async throws -> UserTask {
        let res = try await taskRespository.updateTask(taskId: taskId, title: title, description: description, statusId: statusId, assignedToCode: assignedToCode, assignedByCode: assignedByCode, isActive: isActive)
        return res
    }
}
