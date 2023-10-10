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
    
    var foodEntitys = [FoodEntity]() {
        didSet {
        }
    }
    var isAllRandomFoods = [FoodEntity]()
    var favoriteFoods = [FoodEntity]()
    var likeFoods = [FoodEntity]()
    var foodRecommendationEntityList = [FoodRecommendationListEntity]()
    var recommendedFoods = [FoodEntity]()
//    var categoryList = [CategoryEntity]()
    
    func insertDefaultData() {
        let request = FoodEntity.fetchRequest()
        
        do {
            if try mainContext.count(for: request) == 0 {
                foods.forEach { createFood(
                    imageName: $0.imageName.joined(separator: ", "),
                    name: $0.name, country: $0.country ?? [],
                    numberOfPeople: $0.numberOfPeoPle,
                    categories: $0.categoryList,
                    isAllRandom: $0.isAllRandom,
                    isChecked: $0.isChecked, favorite: $0.favorite) }
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

    func fetchFoodsForLikeCount() {
        let request = FoodEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "likeCount", ascending: true)]
        do {
            likeFoods = try mainContext.fetch(request)
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

    func fetchCategory(category: String) {
        let request = FoodEntity.fetchRequest()

        request.predicate = NSPredicate(format: "categories CONTAINS %@", category)

        do {
            isAllRandomFoods = try mainContext.fetch(request)
        } catch {
            print(error)
        }
    }

    func fetchWithFoodRecommendationListEntity(target: FoodRecommendationListEntity) {
        let foodSet = target.foods as! Set<FoodEntity>
        isAllRandomFoods = Array(foodSet)
    }

    func fetchfavorite() {
        let request = FoodEntity.fetchRequest()

        request.predicate = NSPredicate(format: "favorite == TRUE")

        do {
            favoriteFoods = try mainContext.fetch(request)
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
    
    
    func createFood(imageName: String, name: String,
                    country: [Country] = [],
                    numberOfPeople: [NumberOfPeople] = [],
                    categories: String? = nil,
                    isAllRandom: Bool = true, isChecked: Bool = false,
                    favorite: Bool = false, likeCount: Int = 0) {
        let newEntity = FoodEntity(context: mainContext)
        newEntity.imageName = imageName
        newEntity.name = name
        newEntity.favorite = isAllRandom
        newEntity.isChecked = isChecked
        newEntity.country = country.map { $0.rawValue }.joined(separator: ", ")
        newEntity.numberOfProple = numberOfPeople.map { "\($0.rawValue)" }.joined(separator: ", ")
        newEntity.categories = categories
        newEntity.favorite = favorite
        newEntity.likeCount = Int16(likeCount)
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

    func updateFoodRecommendationList(name: String, description: String, foods: [FoodEntity], foodRecommendationList: FoodRecommendationListEntity) {
        foodRecommendationList.name = name
        foodRecommendationList.listDescription = description
        foodRecommendationList.foods = Set(foods) as NSSet

        do {
            try mainContext.save()
        } catch {
            print(error)
        }
    }

    func updateIsAllRandom(food:FoodEntity, isAllRandom: Bool) {
        food.favorite = isAllRandom
        do {
            try mainContext.save()
        } catch {
            print(error)
        }
    }

    func updatefavorite(food:FoodEntity, favorite: Bool) {
        food.favorite = favorite
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
            foodRecommendationEntityList.removeAll { foodRecommendationListEntity in
                foodRecommendationListEntity == target
            }
        } catch {
            print(error)
        }
    }
    
    func recommenedFoodArray() {
        var set = Set<FoodEntity>()
        while set.count < 5 {
            set.insert(foodEntitys.randomElement()!)
        }

        let array = set.sorted { $0.name ?? "" < $1.name ?? "" }
        recommendedFoods = array
    }

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WhatIsTodaysMenu")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
