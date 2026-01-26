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
        
        var dict: [String: String] = [:]
        res.headers.forEach { dict[$0.name] = $0.value }
        
        return (res.value, dict)
    }
    
    func getTask(id: Int) async throws -> (value: TasksResponseDTO, headers: [String: String]) {
        let res: (value: TasksResponseDTO, headers: Alamofire.HTTPHeaders) = try await client.get("/tasks/\(id)")
        
        var dict: [String: String] = [:]
        res.headers.forEach { dict[$0.name] = $0.value }
        
        return (res.value, dict)
    }
    
    /*func getMyTasks(userUuid: UUID) async throws -> (value: TasksResponseDTO, headers: [String: String]) {
        
    }*/
    
}
