//
//  LocalRepository.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 22/12/25.
//

import Foundation

protocol LocalRepository {
    func getIsLoggedIn () -> Bool
    func setIsLoggedIn(value: Bool)
    func saveLoggedUser(user: UserEntity, token: String?)
    func getLoggedUser() -> UserEntity?
    func clearSession()
}
