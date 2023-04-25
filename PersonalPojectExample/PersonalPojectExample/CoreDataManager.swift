//
//  CoreDataManager.swift
//  PersonalPojectExample
//
//  Created by 김시훈 on 2023/03/30.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    var mainContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    private init() {
        insertDefaultData()
    }
    
    var foodEntitys = [FoodEntity]()
    var isAllRandomFoods = [FoodEntity]()
    var foodRecommendationEntityList = [FoodRecommendationListEntity]()
//    var categoryList = [CategoryEntity]()
    
    func insertDefaultData() {
        let request = FoodEntity.fetchRequest()
        
        do {
            if try mainContext.count(for: request) == 0 {
                foods.forEach { createFood(imageName: $0.imageName.joined(separator: ", "), name: $0.name, country: $0.country ?? [], numberOfPeople: $0.numberOfPeoPle, categories: $0.categoryList, isAllRandom: $0.isAllRandom, isChecked: $0.isChecked) }
            }
        } catch {
            print(error)
        }
    }
    
    func fetchFoods() {
        let request = FoodEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        do {
            foodEntitys = try mainContext.fetch(request)
        } catch {
            print(error)
        }
    }
    
    func fetchFoodRecommendationList() {
        let request = FoodRecommendationListEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        do {
            foodRecommendationEntityList = try mainContext.fetch(request)
        } catch {
            print(error)
        }
    }
    
    func fetchIsAllRandom() {
        let request = FoodEntity.fetchRequest()
        
        request.predicate = NSPredicate(format: "isAllRandom == TRUE")
        
        do {
            isAllRandomFoods = try mainContext.fetch(request)
        } catch {
            print(error)
        }
    }
    
//    func fetchCategory() {
//        let request = CategoryEntity.fetchRequest()
//        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
//        do {
//            categoryList = try mainContext.fetch(request)
//        } catch {
//            print(error)
//        }
//    }
    
    
    func createFood(imageName: String, name: String, country: [Country] = [], numberOfPeople: [NumberOfPeople] = [], categories: String? = nil, isAllRandom: Bool = true, isChecked: Bool = false ) {
        let newEntity = FoodEntity(context: mainContext)
        newEntity.imageName = imageName
        newEntity.name = name
        newEntity.isAllRandom = isAllRandom
        newEntity.isChecked = isChecked
        newEntity.country = country.map { $0.rawValue }.joined(separator: ", ")
        newEntity.numberOfProple = numberOfPeople.map { "\($0.rawValue)" }.joined(separator: ", ")
        newEntity.categories = categories
        
        do {
            try mainContext.save()
        } catch {
            print(error)
        }
    }
    
    func createFoodRecommendationList(name: String, description: String, foods: [FoodEntity]) {
        let newEntity = FoodRecommendationListEntity(context: mainContext)
        newEntity.name = name
        newEntity.listDescription = description
        newEntity.foods = Set(foods) as NSSet
        
        do {
            try mainContext.save()
        } catch {
            print(error)
        }
    }
    
    func updateIsAllRandom(food:FoodEntity, isAllRandom: Bool) {
        food.isAllRandom = isAllRandom
        do {
            try mainContext.save()
        } catch {
            print(error)
        }
    }
    
    
    func removeFoodRecommendationList(target: FoodRecommendationListEntity) {
        mainContext.delete(target)
        do {
            try mainContext.save()
            foodRecommendationEntityList.removeAll { FoodRecommendationListEntity in
                FoodRecommendationListEntity == target
            }
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
