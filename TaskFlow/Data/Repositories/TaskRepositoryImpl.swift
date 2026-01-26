//
//  TaskRepositoryImpl.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 25/01/26.
//

import Foundation

final class TaskRepositoryImpl: TaskRepository {
    private let api: TaskAPI
    
    init(api: TaskAPI) {
        self.api = api
    }
    
    func createTask(title: String, description: String, statusId: Int, assignedTo: String, assignedBy: String) async throws -> UserTask {
        let res = try await api.createTask(title: title, description: description, statusId: statusId, assignedTo: assignedTo, assignedBy: assignedBy)
        
        let task = UserTask(id: res.task.data.id, title: res.task.data.title, description: res.task.data.description, statusId: res.task.data.statusId, assignedToCode: res.task.data.assignedToCode, assignedByCode: res.task.data.assignedByCode, assignedAt: res.task.data.assignedAt, createdAt: res.task.data.createdAt, updatedAt: res.task.data.updatedAt, isActive: res.task.data.isActive, assignedBy: nil, assignedTo: nil, status: nil)
        
        return task
    }
    
    func getTasks() async throws -> [UserTask] {
        let res = try await api.getAllTasks()
        
        let tasks = res.value.data.map { task in
            UserTask(id: task.id, title: task.title, description: task.description, statusId: task.statusId, assignedToCode: task.assignedToCode, assignedByCode: task.assignedByCode, assignedAt: task.assignedAt, createdAt: task.createdAt, updatedAt: task.updatedAt, isActive: task.isActive, assignedBy: task.assignedBy != nil ? UserAssigned(id: task.assignedBy!.id, uuid: task.assignedBy!.uuid, email: task.assignedBy!.email, name: task.assignedBy!.name, lastName: task.assignedBy!.lastName, secondLastName: task.assignedBy?.secondLastName ?? "", userCode: task.assignedBy!.userCode, roleId: task.assignedBy!.roleId, enabled: task.assignedBy!.enabled) : nil, assignedTo: nil, status: nil)
            
        }
        
        return tasks
    }
}
