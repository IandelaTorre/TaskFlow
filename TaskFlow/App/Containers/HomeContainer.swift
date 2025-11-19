//
//  HomeContainer.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 18/11/25.
//

import Foundation

final class HomeContainer {
    @MainActor func makeHomeViewModel() -> HomeViewModel {
        return HomeViewModel()
    }
}
