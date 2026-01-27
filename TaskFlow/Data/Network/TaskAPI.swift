//
//  TaskAPI.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 21/01/26.
//

import Foundation
import Alamofire

final class TaskAPI {
    private let client: APIClient
    
    init(client: APIClient) {
        self.client = client
    }
    
    func createTask(title: String, description: String, statusId: Int, assignedTo: String, assignedBy: String) async throws -> (task: CreateTaskResponseDTO, headers: [String: String]) {
        let dto = CreateTaskRequestDTO(title: title, description: description, statusId: statusId, assignedToCode: assignedTo, assignedByCode: assignedBy)
        let res: (value: CreateTaskResponseDTO, headers: Alamofire.HTTPHeaders) = try await client.post("/tasks", body: dto)
        
        var dict: [String: String] = [:]
        res.headers.forEach { dict[$0.name] = $0.value }
        return (res.value, dict)
    }
    
    func updateTask(taskId: Int, title: String?, description: String?, statusId: Int?, assignedToCode: String?, assignedByCode: String?, isActive: Bool?) async throws -> (task: TaskResponseDTO, headers: [String: String]) {
        let dto = UpdateTaskRequestDTO(title: title, description: description, statusId: statusId, assignedToCode: assignedToCode, assignedByCode: assignedByCode, isActive: isActive)
        let res: (value: TaskResponseDTO, headers: Alamofire.HTTPHeaders) = try await client.patch("/tasks/\(taskId)", body: dto)
        
        var dict: [String: String] = [:]
        res.headers.forEach { dict[$0.name] = $0.value }
        return (res.value, dict)
    }
    
    func getAllTasks() async throws -> (value: TasksResponseDTO, headers: [String: String]) {
        /*let queryParams: [String: Any] = [
                "isActive": isActive,
                "page": page
            ]
            
            let res: (value: TasksResponseDTO, headers: Alamofire.HTTPHeaders) = try await client.get(
                "/tasks",
                parameters: queryParams
            ) */
        let res: (value: TasksResponseDTO, headers: Alamofire.HTTPHeaders) = try await client.get("/tasks")
        print("TaskAPI: \(res.value)")
        
        var dict: [String: String] = [:]
        res.headers.forEach { dict[$0.name] = $0.value }
        
        return (res.value, dict)
    }
    
    func getTask(id: Int) async throws -> (value: TaskResponseDTO, headers: [String: String]) {
        let res: (value: TaskResponseDTO, headers: Alamofire.HTTPHeaders) = try await client.get("/tasks/\(id)")
        
        var dict: [String: String] = [:]
        res.headers.forEach { dict[$0.name] = $0.value }
        
        return (res.value, dict)
    }
    
    func getMyTasks(userUuid: UUID) async throws -> (value: TasksResponseDTO, headers: [String: String]) {
        let path = "/tasks/user/" + userUuid.uuidString
        let params: [String: String] = [
            "include": "status,assignedBy,assignedTo"
        ]
        let res: (value: TasksResponseDTO, headers: Alamofire.HTTPHeaders) = try await client.get(path, parameters: params)
        
        var dict: [String: String] = [:]
        res.headers.forEach { dict[$0.name] = $0.value }
        print("Se trajeron los datos de la API: \(res.value)")
        
        return (res.value, dict)
    }
    
}
