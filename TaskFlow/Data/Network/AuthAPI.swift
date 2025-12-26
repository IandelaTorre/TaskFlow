//
//  AuthAPI.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 22/12/25.
//

import Foundation
import Alamofire

final class AuthAPI {
    private let client: APIClient
    
    init(client: APIClient) {
        self.client = client
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
