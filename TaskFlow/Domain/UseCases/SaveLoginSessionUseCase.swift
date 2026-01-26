//
//  SaveLoginSessionUseCase.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 22/12/25.
//

import Foundation

final class SaveLoginSessionUseCase {
    private let localRepository: LocalRepository
    
    init(localRepository: LocalRepository) {
        self.localRepository = localRepository
    }
    
    func execute(user: UserEntity, token: String?) {
        localRepository.saveLoggedUser(user: user, token: token)
        localRepository.setIsLoggedIn(value: true)
    }
}
