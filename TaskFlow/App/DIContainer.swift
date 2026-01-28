//
//  DIContainer.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 18/11/25.
//

import Foundation
import Alamofire

final class DIContainer {
    lazy var afSession: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        
        configuration.httpCookieStorage = HTTPCookieStorage.shared
        configuration.httpShouldSetCookies = true
        
        return Session(configuration: configuration)
    }()
    
    lazy var apiClient: APIClient = APIClient(session: afSession, baseURL: "https://backendnestjs-6rmq.onrender.com/api/v1")
    lazy var authAPI: AuthAPI = AuthAPI(client: apiClient)
    lazy var taskAPI: TaskAPI = TaskAPI(client: apiClient)
    lazy var authRepository: AuthRepository = AuthRepositoryImpl(api: authAPI)
    lazy var localRepository: LocalRepository = LocalRepositoryImpl(coreData: .shared)
    lazy var taskRepository: TaskRepository = TaskRepositoryImpl(api: taskAPI)
    lazy var home = HomeContainer(di: self)
    lazy var login = LoginContainer(di: self)
    
}
