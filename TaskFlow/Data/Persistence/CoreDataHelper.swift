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
    
    func getIsLoggedIn() -> Bool {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        if let result = try? context.fetch(fetchRequest), let session = result.first {
            print("isloggedIn desde Helper: \(session.isLoggedIn)")
            return session.isLoggedIn
        } else {
            return false
        }
    }
    
    func setIsLoggedIn(_ value: Bool) {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        if let result = try? context.fetch(fetchRequest), let session = result.first {
            session.isLoggedIn = value
        } else {
            let newUser = User(context: context)
            newUser.isLoggedIn = value
        }
        try? context.save()
    }
}
