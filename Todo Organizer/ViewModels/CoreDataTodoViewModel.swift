//
//  CoreDataTodoViewModel.swift
//  Todo Organizer
//
//  Created by user220431 on 8/3/22.
//

/*
 Storage options overview
 UserDefaults: default storage use for very small bits of data (top score, nickname, music starts on/off, etc(
 Should not be used for storing objects generally, mostly primitive types
 Codable: P list storage.  A great way to freeze custom object but loading requires loading the entire list every time.
 P lists should be small (< 100kb) and specific to minimize load times.
 Keychain: Save small bits of data securely using this API.  Apple handles most of the security
 Databases:
 SQLite: Lightweight db.  Look into FMDB as a wrapper to utilize SQLite
 Core Data: Object oriented db.  Can use SQLite but adds a ton of functionality for monitoring, manipulation, etc
 Realm: Faster, open source option instead of Core Data.
 */

import Foundation
import CoreData

class CoreDataTodoViewModel: ObservableObject {
    let logPrefix = "[UserDefaultTodoListViewModel] "
    @Published var itemsArray = [CoreDataTodo]()
    // Use core data singleton context
    let context: NSManagedObjectContext
    
    init(coreDataContext context: NSManagedObjectContext) {
        self.context = context
        loadData()
        
    }
    
    // MARK: Save Changes Section
    func saveTodoChangesToStorage() {
        print(logPrefix + "Saving with Core Data")
        do {
            try context.save()
        } catch {
            print(logPrefix + "Error while saving new todo to Core Data")
            print(logPrefix + "Error: \(error)")
        }
    }
    
    // MARK: Create Item Section
    func addTodoItem(title: String, body: String) {
        
        // Creates todo for a Core Data Object
        let newTodo = CoreDataTodo(context: context)
        newTodo.title = title
        newTodo.body = body
        newTodo.timestamp = Date()
        
        saveTodoChangesToStorage()
        loadData()
    }
    
    // MARK: Read Items Section
    func loadData() {
        let request: NSFetchRequest<CoreDataTodo> = CoreDataTodo.fetchRequest()
        do {
            print(logPrefix + "Fetching Todo List from Core Data")
            
            if try context.count(for: request) == 0 {
                itemsArray = []
            }
            else {
                itemsArray = try context.fetch(request)
            }
            
        } catch {
            print(logPrefix + "Error fetching Todo List from Core Data")
            print("Error: \(error)")
        }
    }
    
    // MARK: Update Item Section
    func toggleCompleted(for todo: CoreDataTodo) {
        
        if let selectedTodo = itemsArray.firstIndex(where: {$0.title == todo.title}) {
            itemsArray[selectedTodo].isComplete.toggle()
            print(logPrefix + "\(String(describing: itemsArray[selectedTodo].title)) has been marked \(itemsArray[selectedTodo].isComplete)")
            saveTodoChangesToStorage()
        } else {
            print(logPrefix + "Could not locate Todo to toggle completion")
            
        }
        
        
    }
    
    // MARK: Delete Item Section
    func deleteItem(at todoIndex: Int) {
        print(logPrefix + "Deleting item at index \(todoIndex)")
        context.delete(itemsArray[todoIndex])
        
        if itemsArray.count == 1 {
            itemsArray.removeAll()
        } else {
            itemsArray.remove(at: todoIndex)
        }
        
        saveTodoChangesToStorage()
        loadData()
        
    }
}
