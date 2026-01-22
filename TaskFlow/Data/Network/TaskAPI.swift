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
    
    func createTask(title: String, description: String, statusId: Int, assignedTo: UUID, assignedBy: UUID) async throws -> CreateTaskRequestDTO {
        return CreateTaskRequestDTO(title: "", description: "", statusId: 1, assignedTo: UUID(), assignedBy: UUID())
    }
    
    func login(username: String, password: String, time: Int?) async throws -> (user: LoginResponseDTO, headers: [String: String]) {
        let dto = LoginRequestDTO(email: username, password: password, expirationDays: time)
        let res: (value: LoginResponseDTO, headers: Alamofire.HTTPHeaders) = try await client.post("/auth/login", body: dto)
        
        var dict: [String: String] = [:]
        res.headers.forEach { dict[$0.name] = $0.value }
        print("AuthAPI (res value): \(res.value)")
        return (res.value, dict)
    }
}
