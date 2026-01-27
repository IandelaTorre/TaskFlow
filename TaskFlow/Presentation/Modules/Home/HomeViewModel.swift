//
//  HomeViewModel.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 18/11/25.
//

import Foundation
import Combine

class HomeViewModel {
    private let createTaskUseCase: CreateTaskUseCase
    private let getTasksUseCase: GetTasksUseCase
    private let getMyTasksUseCase: GetMyTasksUseCase
    private let getTaskUseCase: GetTaskUseCase
    private let updateTaskUseCase: UpdateTaskUseCase
    
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String? = ""
    
    @Published var user: User? = nil
    @Published var tasks: [UserTask]? = nil
    @Published var detailTask: UserTask? = nil
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(createTaskUseCase: CreateTaskUseCase, getTasksUseCase: GetTasksUseCase, getMyTasksUseCase: GetMyTasksUseCase, getTaskUseCase: GetTaskUseCase, updateTaskUseCase: UpdateTaskUseCase) {
        self.createTaskUseCase = createTaskUseCase
        self.getTasksUseCase = getTasksUseCase
        self.getMyTasksUseCase = getMyTasksUseCase
        self.getTaskUseCase = getTaskUseCase
        self.updateTaskUseCase = updateTaskUseCase
    }
    
    func createTask(title: String, description: String, statusId: Int, assignedTo: String, assignedBy: String) async -> Bool {
        isLoading = true
        defer { isLoading = false }
        
        do {
            _ = try await createTaskUseCase.execute(title: title, description: description, statusId: statusId, assignedTo: assignedTo, assignedBy: assignedBy)
            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }
    
    func updateTask(taskId: Int, task: UserTask) async -> Bool {
        isLoading = true
        defer { isLoading = false }
        
        do {
            _ = try await updateTaskUseCase.execute(taskId: taskId, title: task.title, description: task.description, statusId: task.statusId, assignedToCode: task.assignedToCode, assignedByCode: task.assignedByCode, isActive: task.isActive)
            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }
    
    func loadUser() {
        if let user = CoreDataHelper.shared.fetchFirstUser() {
            self.user = user
        } else {
            print("No se encontro el usuario en la persistencia. ")
        }
    }
    
    func fetchTasks() {
        isLoading = true
        defer { isLoading = false }
        
        Task {
            do {
                let fetchedTasks = try await getTasksUseCase.execute()
                print(fetchedTasks)
                self.tasks = fetchedTasks
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func fetchMyTasks(userUuid: UUID) {
        isLoading = true
        defer { isLoading = false }
        
        Task {
            do {
                let fetchedTasks = try await getMyTasksUseCase.execute(userUuid: userUuid)
                print(fetchedTasks)
                self.tasks = fetchedTasks
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func fetchTask(taskId: Int) async -> Bool {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let task = try await getTaskUseCase.execute(taskId: taskId)
            self.detailTask = task
            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }
}
