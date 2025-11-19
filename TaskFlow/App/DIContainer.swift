//
//  DIContainer.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 18/11/25.
//

import Foundation

final class DIContainer {
    @MainActor func makeTaskFlowViewModel() -> TaskFlowViewModel {
        /*let repository: RatesRepository
        let getRates = GetLatestRatesUseCase(repository: repository)
        let convertUseCase = ConvertCurrencyUseCase() */
        return TaskFlowViewModel()
    }
}
