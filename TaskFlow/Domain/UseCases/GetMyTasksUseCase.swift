//
//  GetMyTasksUseCase.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 25/01/26.
//

import Foundation

final class GetMyTasksUseCase {
    private let taskRepository: TaskRepository
    
    init(taskRepository: TaskRepository) {
        self.taskRepository = taskRepository
    }
    
    func execute(userUuid: UUID) async throws -> [UserTask] {
        let result = try await taskRepository.getMyTasks(userUuid: userUuid)
        return result
    }
}
