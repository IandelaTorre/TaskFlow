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
    
    func saveLoggedUser(id: Int64, email: String, name: String?, lastName: String?, secondLastName: String?, userCode: String, roleId: String, jwt: String?) {
        let user = fetchFirstUser() ?? User(context: context)
        user.userId = id
        user.userCode = userCode
        user.name = name
        user.lastName = lastName
        user.secondLastName = secondLastName
        user.roleId = roleId
        user.email = email
        user.accessToken = jwt
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
}
