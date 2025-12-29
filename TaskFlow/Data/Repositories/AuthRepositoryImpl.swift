//
//  AuthRepositoryImpl.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 22/12/25.
//

import Foundation

final class AuthRepositoryImpl: AuthRepository {
    private let api: AuthAPI
    
    init(api: AuthAPI) {
        self.api = api
    }
    
    func login(username: String, password: String, time: Int?) async throws -> (user: UserEntity, token: String?) {
        let res = try await api.login(username: username, password: password, time: time ?? 1)
        // let jwt = Self.extractJWT(from: res.headers)
        //let userRole = UserRole()
        
        /*if let role = res.user.role {
            let userRole = UserRole(id: role.id, name: role.name, visualName: role.visualName, createdAt: role.createdAt)
        }  PENDIENTE */
                
        let user = UserEntity(id: res.user.data.id, email: res.user.data.email, name: res.user.data.name, lastName: res.user.data.lastName, secondLastName: res.user.data.secondLastName, createdAt: res.user.data.createdAt, updatedAt: res.user.data.updatedAt, enabled: res.user.data.enabled, roleId: res.user.data.roleId, uuid: res.user.data.uuid, userCode: res.user.data.userCode, role: nil)
        print("AuthRepositoryImpl: \(res.user)")
        
        return (user, res.user.data.accessToken)
    }
    
    func signup(name: String, lastName: String, email: String, password: String) async throws -> UserEntity {
        let res = try await api.signup(name: name, lastName: lastName, email: email, password: password)
        print("res.data (AuthRepositoryImpl): \(res.data)")
        
        let user = UserEntity(id: res.data.id, email: res.data.email, name: res.data.name, lastName: res.data.lastName, secondLastName: res.data.secondLastName, createdAt: res.data.createdAt, updatedAt: res.data.updatedAt, enabled: res.data.enabled, roleId: res.data.roleId, uuid: res.data.uuid, userCode: res.data.userCode, role: nil)
        
        return user
    }
    
    func recoveryPassword(email: String, recoveryCode: String, newPassword: String) async throws -> RecoveryPassword {
        let res = try await api.recoveryPassword(email: email, recoveryCode: recoveryCode, newPassword: newPassword)
        
        let userData = UserData(uuid: res.user.uuid, email: res.user.email)
        let response = RecoveryPassword(message: res.message, user: userData)
        
        return response
    }
    
    private static func extractJWT(from headers: [String: String]) -> String? {
        let candidates = ["Authorization", "authorization", "Authorizer", "authorizer", "X-Authorization", "x-authorization"]
        for key in candidates {
            if let value = headers[key], !value.isEmpty {
                if value.lowercased().hasPrefix("bearer ") {
                    return String(value.dropFirst("bearer ".count))
                }
                return value
            }
        }
        return nil
    }
}
