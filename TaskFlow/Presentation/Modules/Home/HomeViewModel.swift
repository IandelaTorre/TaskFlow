//
//  HomeViewModel.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 18/11/25.
//

import Foundation
import Combine

class HomeViewModel {
    
    @Published private(set) var isLoading: Bool = false
    
    @Published var user: User? = nil
    @Published var tasks: [UserTask]? = nil
    
    private var cancellables: Set<AnyCancellable> = []
    
    func loadUser() {
        if let user = CoreDataHelper.shared.fetchFirstUser() {
            self.user = user
        } else {
            print("No se encontro el usuario en la persistencia. ")
        }
    }
    
    func fetchTasks() {
        // MARK: - Mock Data para Pruebas

        let mockTasks: [UserTask] = [
            // 1. Tarea Pendiente (Sin completar)
            UserTask(
                title: "Revisar arquitectura de red",
                description: "Analizar los diagramas de flujo y verificar la latencia en los nodos principales del sector norte.",
                status: UserTaskStatus(id: "1", code: "PROG", name: "En progreso"),
                assignedTo: UserAssigned(id: "u1", userCode: "IPEREZ", name: "Ian", lastName: "Pérez"),
                assignedBy: UserAssigned(id: "u2", userCode: "ADMIN", name: "Sistema", lastName: "Global"),
                assignedAt: Date(),
                createdAt: Date().addingTimeInterval(-86400), // Ayer
                updatedAt: Date(),
                isEnabled: true
            ),
            
            // 2. Tarea Completada (Para probar el icono de Ready)
            UserTask(
                title: "Entrevistas de QA",
                description: "Finalizar la terna de candidatos para la vacante de automatización móvil.",
                status: UserTaskStatus(id: "2", code: "DONE", name: "Completada"),
                assignedTo: UserAssigned(id: "u1", userCode: "IPEREZ", name: "Ian", lastName: "Pérez"),
                assignedBy: UserAssigned(id: "u3", userCode: "HR_MGR", name: "Laura", lastName: "García"),
                assignedAt: Date().addingTimeInterval(-172800), // Hace 2 días
                createdAt: Date().addingTimeInterval(-172800),
                updatedAt: Date(),
                isEnabled: true
            ),
            
            // 3. Tarea con descripción larga (Para probar el scroll y expansión)
            UserTask(
                title: "Actualización de certificados SSL",
                description: "Es necesario renovar los certificados de los servidores de staging y producción antes del próximo viernes para evitar caídas en el servicio.",
                status: UserTaskStatus(id: "3", code: "PEND", name: "Pendiente"),
                assignedTo: UserAssigned(id: "u1", userCode: "IPEREZ", name: "Ian", lastName: "Pérez"),
                assignedBy: UserAssigned(id: "u2", userCode: "ADMIN", name: "Sistema", lastName: "Global"),
                assignedAt: Date(),
                createdAt: Date(),
                updatedAt: Date(),
                isEnabled: true
            )
        ]
        self.tasks = mockTasks
    }
}
