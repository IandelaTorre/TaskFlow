//
//  TaskRepository.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 25/01/26.
//

import Foundation

protocol TaskRepository {
    func createTask(title: String, description: String, statusId: Int, assignedTo: String, assignedBy: String) async throws -> UserTask
    func getTasks() async throws -> [UserTask]
    func getTask(taskId: Int) async throws -> UserTask
    func getMyTasks(userUuid: UUID) async throws -> [UserTask]
}
