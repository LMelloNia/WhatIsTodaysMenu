//
//  CoreDataManager.swift
//  PersonalPojectExample
//
//  Created by 김시훈 on 2023/03/30.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let shared = CoreDataManager()
    
    var mainContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    var FoodList = [FoodListEntity]()
    
    func fetch() {
        let request = FoodListEntity.fetchRequest()
        do {
            FoodList = try mainContext.fetch(request)
        } catch {
            print(error)
        }
    }
    
    func create() {
        
        do {
            try mainContext.save()
        } catch {
            print(error)
        }
    }
    // MARK: - Core Data stack
    
    // (SQLite, memory, XML) <-Coredata-> code
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "PersonalPojectExample")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    // NSManagedObjectContext 메모리
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
