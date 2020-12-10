//
//  DataManager.swift
//  SmartCart
//
//  Created by Zhyvel Maksim on 12/8/20.
//

import Foundation
import CoreData

open class DataManager: NSObject{
    
    public static let sharedInstance = DataManager()
    
    private lazy var GroceryListEntity: NSEntityDescription = {
            let managedContext = getContext()
            return NSEntityDescription.entity(forEntityName: "GroceryList", in: managedContext!)!
        }()
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataBase")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
        if let error = error as NSError? {
            fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
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
    private override init() {}

    // Helper func for getting the current context.
    private func getContext() -> NSManagedObjectContext? {
        return persistentContainer.viewContext
    }

    func retrieveGroceryList() -> NSManagedObject? {
        guard let managedContext = getContext() else { return nil }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GroceryList")

        do {
            let result = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            if result.count > 0 {
                return result[0]
            } else {
                createUser()
                return nil
            }
        } catch let error as NSError {
            print("Retrieiving user failed. \(error): \(error.userInfo)")
           return nil
        }
    }
    
    func createUser() {
            guard let managedContext = getContext() else { return }
            _ = NSManagedObject(entity: GroceryListEntity, insertInto: managedContext)
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Failed to save new user! \(error): \(error.userInfo)")
            }
        }

    func saveGroceryList(_ ProductsList: [Product]) {
        guard let managedContext = getContext() else { return }
        guard let GroceryList = retrieveGroceryList() else { return }

        GroceryList.setValue(ProductsList, forKey: "products")
        
        do {
            print("Saving session...")
            try managedContext.save()
        } catch let error as NSError {
            print("Failed to save session data! \(error): \(error.userInfo)")
        }
    }
    
    func restoreGroceryList() -> [Product] {
            let managedContext = persistentContainer.viewContext
            let prds: [Product] = []
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "GroceryList")
            do {
                let result = try managedContext.fetch(fetchRequest)
                if let groceryList = result.first as? GroceryList,
                   let products = groceryList.products {
                    return products
                }
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
            return prds
        }
}
