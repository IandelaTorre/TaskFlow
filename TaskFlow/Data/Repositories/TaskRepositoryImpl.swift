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
        print("res(TaskRepositoryImpl): \(res)")
        
        let tasks = res.value.data.map { task in
            UserTask(id: task.id, title: task.title, description: task.description, statusId: task.statusId, assignedToCode: task.assignedToCode, assignedByCode: task.assignedByCode, assignedAt: task.assignedAt, createdAt: task.createdAt, updatedAt: task.updatedAt, isActive: task.isActive, assignedBy: task.assignedBy != nil ? UserAssigned(id: task.assignedBy!.id, uuid: task.assignedBy!.uuid, email: task.assignedBy!.email, name: task.assignedBy!.name, lastName: task.assignedBy!.lastName, secondLastName: task.assignedBy?.secondLastName ?? "", userCode: task.assignedBy!.userCode, roleId: task.assignedBy!.roleId, enabled: task.assignedBy!.enabled) : nil, assignedTo: nil, status: task.status != nil ? UserTaskStatus(statusId: task.status!.statusId, code: task.status!.code, name: task.status!.name, description: task.status!.description, isActive: task.status!.isActive) : nil)
        }
        
        return tasks
    }
    
    func getTask(taskId: Int) async throws -> UserTask {
        let res = try await api.getTask(id: taskId)
        
        let task = UserTask(id: res.value.data.id, title: res.value.data.title, description: res.value.data.description, statusId: res.value.data.statusId, assignedToCode: res.value.data.assignedToCode, assignedByCode: res.value.data.assignedByCode, assignedAt: res.value.data.assignedAt, createdAt: res.value.data.createdAt, updatedAt: res.value.data.updatedAt, isActive: res.value.data.isActive, assignedBy: res.value.data.assignedBy != nil ? UserAssigned(id: res.value.data.assignedBy!.id, uuid: res.value.data.assignedBy!.uuid, email: res.value.data.assignedBy!.email, name: res.value.data.assignedBy!.name, lastName: res.value.data.assignedBy!.lastName, secondLastName: res.value.data.assignedBy!.secondLastName, userCode: res.value.data.assignedBy!.userCode, roleId: res.value.data.assignedBy!.roleId, enabled: res.value.data.assignedBy!.enabled) : nil, assignedTo: res.value.data.assignedTo != nil ? UserAssigned(id: res.value.data.assignedTo!.id, uuid: res.value.data.assignedTo!.uuid, email: res.value.data.assignedTo!.email, name: res.value.data.assignedTo!.name, lastName: res.value.data.assignedTo!.lastName, secondLastName: res.value.data.assignedTo!.secondLastName, userCode: res.value.data.assignedTo!.userCode, roleId: res.value.data.assignedTo!.roleId, enabled: res.value.data.assignedTo!.enabled) : nil, status: res.value.data.status != nil ? UserTaskStatus(statusId: res.value.data.status!.statusId, code: res.value.data.status!.code, name: res.value.data.status!.name, description: res.value.data.status!.description, isActive: res.value.data.status!.isActive) : nil)
        
        return task
    }
    
    func getMyTasks(userUuid: UUID) async throws -> [UserTask] {
        let res = try await api.getMyTasks(userUuid: userUuid)
        
        let tasks = res.value.data.map { task in
            UserTask(id: task.id, title: task.title, description: task.description, statusId: task.statusId, assignedToCode: task.assignedToCode, assignedByCode: task.assignedByCode, assignedAt: task.assignedAt, createdAt: task.createdAt, updatedAt: task.updatedAt, isActive: task.isActive, assignedBy: task.assignedBy != nil ? UserAssigned(id: task.assignedBy!.id, uuid: task.assignedBy!.uuid, email: task.assignedBy!.email, name: task.assignedBy!.name, lastName: task.assignedBy!.lastName, secondLastName: task.assignedBy?.secondLastName ?? "", userCode: task.assignedBy!.userCode, roleId: task.assignedBy!.roleId, enabled: task.assignedBy!.enabled) : nil, assignedTo: nil, status: task.status != nil ? UserTaskStatus(statusId: task.status!.statusId, code: task.status!.code, name: task.status!.name, description: task.status!.description, isActive: task.status!.isActive) : nil)
        }
        
        return tasks
    }
}
