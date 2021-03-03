//
//  PersistanceStorage.swift
//  PostFavoritesAssignment
//
//  Created by Thejeswara Reddy on 02/03/21.
//

import Foundation
import CoreData

class PersistanceStorage {
    
    static var shared = PersistanceStorage()
    
    private init(){}
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "PostFavoritesAssignment")
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
    
    lazy var context = persistentContainer.viewContext

    // MARK: - Core Data Saving support

    func saveContext () {
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
    
    func fetchRequests<T:NSManagedObject>(managedObject:T.Type)->[T]?{
        do{
            guard let result = try PersistanceStorage.shared.context.fetch(managedObject.fetchRequest()) as? [T] else {return nil}
            return result
        }catch let error{
            print(error.localizedDescription)
        }
        return nil
    }
    func delete<T:NSManagedObject>(managedObject:T.Type) -> Bool{
        do{
            guard let result = try PersistanceStorage.shared.context.fetch(managedObject.fetchRequest()) as? [T] else {return false}
            for each in result{
                context.delete(each)
                try context.save()
            }
            return true
        }catch let error{
            print(error.localizedDescription)
        }
        return true
    }
}
