//
//  LocalRepositoryImpl.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 24/12/25.
//

import Foundation

final class LocalRepositoryImpl: LocalRepository {    
    private let coreData: CoreDataHelper
    
    init(coreData: CoreDataHelper) {
        self.coreData = coreData
    }
    
    func getIsLoggedIn() -> Bool {
        coreData.getIsLoggedIn()
    }
    
    func setIsLoggedIn(value: Bool) {
        coreData.setIsLoggedIn(value)
    }
    
    func saveLoggedUser(user: UserEntity, token: String?) {
        
        coreData.saveLoggedUser(id: Int64(user.id), email: user.email, name: user.name, lastName: user.lastName, secondLastName: user.secondLastName, userCode: user.userCode, roleId: String(user.roleId), jwt: token)
    }
    
    func getLoggedUser() -> UserEntity? {
        return nil
    }
    
    func clearSession() {
        coreData.clearSession()
    }
}
