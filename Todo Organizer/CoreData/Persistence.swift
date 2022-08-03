//
//  Persistence.swift
//  Todo Organizer
//
//  Created by user220431 on 8/3/22.
//

import CoreData

struct PersistenceController {
    
    let logPrefix = "[PersistenceController] "
    
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newItem = CoreDataTodo(context: viewContext)
            newItem.timestamp = Date()
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "TodoDataModel")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    // Compares context to confirm if uncommitted changes need to be saved
    func save() {
        let context = container.viewContext
        
        print(logPrefix + "Reviewing context for changes...")
        if context.hasChanges {
            print(logPrefix + "Changes found.")
            do {
                try context.save()
                print(logPrefix + "Context Saved!")
            } catch {
                print(logPrefix + "Error saving context changes to db")
            }
        } else {
            print(logPrefix + "No changes detected.")
        }
    }
}
