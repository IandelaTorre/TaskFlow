//
//  CoreDataHelper.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 25/11/25.
//

import UIKit
import CoreData

final class CoreDataHelper {
    static let shared = CoreDataHelper()
    private init() {}
    
    private var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func fetchFirstUser() -> User? {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        return (try? context.fetch(fetchRequest))?.first
    }
    
    func getIsLoggedIn() -> Bool {
        let user = fetchFirstUser()
        print("IsLoggedIn desde Helper: \(user?.isLoggedIn ?? false)")
        return user?.isLoggedIn ?? false
    }
    
    func getUserInfo() -> String {
        if let user = fetchFirstUser() {
            return "IsLoggedIn: \(user.isLoggedIn)\n Token: \(user.accessToken ?? "")"
        }
        return "Sin información almacenada"
        
    }
    
    func saveLoggedUser(id: Int64, uuid: UUID, email: String, name: String?, lastName: String?, secondLastName: String?, userCode: String, roleId: String, enabled: Bool, jwt: String?) {
        let user = fetchFirstUser() ?? User(context: context)
        print("CoreDataHelper(user): \(user)")
        user.userId = id
        user.userUuid = uuid
        user.userCode = userCode
        user.name = name
        user.lastName = lastName
        user.secondLastName = secondLastName
        user.roleId = roleId
        user.email = email
        user.enabled = enabled
        user.accessToken = jwt
        user.isLoggedIn = true
        
        do {
            try context.save()
            print("Se guardo el usuario")
        } catch {
            print("No se pudo guardar el usuario: \(error.localizedDescription)")
        }
    }
    
    func clearSession() {
        if let user = fetchFirstUser() {
            user.isLoggedIn = false
            user.accessToken = nil
            try? context.save()
        }
    }
    
    func setIsLoggedIn(_ value: Bool) {
        let user = fetchFirstUser() ?? User(context: context)
        user.isLoggedIn = value
        try? context.save()
    }
    
    func printCurrentUserData() {
        if let user = fetchFirstUser() {
            print("""
            --------- USUARIO EN CORE DATA ---------
            ID: \(user.userId)
            UUID: \(user.userUuid?.uuidString ?? "N/A")
            Nombre: \(user.name ?? "") \(user.lastName ?? "")
            Email: \(user.email ?? "")
            Code: \(user.userCode ?? "")
            Role ID: \(user.roleId ?? "")
            Loggeado: \(user.isLoggedIn)
            Token: \(user.accessToken ?? "N/A")
            ----------------------------------------
            """)
        } else {
            print("--------- CORE DATA VACÍO ---------")
        }
    }
}
