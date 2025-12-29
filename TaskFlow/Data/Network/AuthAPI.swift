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
    
    func signup(name: String, lastName: String, email: String, password: String) async throws -> SignupResponseDTO {
        let dto = SignupRequestDTO(name: name, lastName: lastName, email: email, password: password)
        let res: (value: SignupResponseDTO, headers: Alamofire.HTTPHeaders) = try await client.post("/auth/signup", body: dto)
        return res.value
    }
    
    func recoveryPassword(email: String, recoveryCode: String, newPassword: String) async throws -> RecoveryPasswordResponseDTO {
        let dto = RecoveryPasswordRequestDTO(email: email, recoveryCode: recoveryCode, newPassword: newPassword)
        let res: (value: RecoveryPasswordResponseDTO, headers: Alamofire.HTTPHeaders) = try await client.post("/auth/recovery-password", body: dto)
        return res.value
    }
}
