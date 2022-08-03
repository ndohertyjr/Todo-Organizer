//
//  MainViewModel.swift
//  Todo Organizer
//
//  Created by user220431 on 7/29/22.
//

import Foundation
import UIKit
import CoreData

/*
    ViewModel to handle the data for the TodoList Views.
    Shows different potential options for storing data in persistent storage.
*/

// ViewModel Protocol


class TodoListViewModel: ObservableObject {
    
    @Published var itemsArray = [Todo]()
    let dataHandler = DataHandler()
    
    // Storage options
    let defaults = UserDefaults.standard
    let dataFilePath = Constants.persistentStorage.dataFilePath
    
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
    enum StorageSelection {
        case defaultStorage
        case pListStorage
        case coreDataStorage
    }
    
    var storageChoice = StorageSelection.coreDataStorage
    // Use core data singleton context
    let context: NSManagedObjectContext
    
    let logPrefix = "[TodoListViewModel] "
    
    init(coreDataContext context: NSManagedObjectContext) {
        self.context = context
        loadItems()
        
    }
    
    // Uses storage selection
    func saveTodoChangesToStorage() {
        switch storageChoice {
            // Custom object encoded to store to defaults
            case .defaultStorage:
                if let safeData = dataHandler.encodeTodoDataForJSON(for: itemsArray) {
                    defaults.set(safeData, forKey: Constants.persistentStorage.arrayModels.todoListArray)
                }
                else {
                    print(logPrefix + "Error adding todo to list!  Data not encoded correctly.")
                }
            //Custom object encoded to store to pList
            case .pListStorage:
                if let safeData = dataHandler.encodeTodoDataForPList(for: itemsArray) {
                    do {
                        try safeData.write(to: dataFilePath!)
                        print(logPrefix + "Saved to Core Data")
                    } catch {
                        print(logPrefix + "Failed to add todo item to Property List")
                    }
                }
            // Store data using core data model
            case .coreDataStorage:
                print(logPrefix + "Saving with Core Data")
                do {
                    try context.save()
                } catch {
                    print(logPrefix + "Error while saving new todo to Core Data")
                    print(logPrefix + "Error: \(error)")
                }
            default:
                print(logPrefix + "Unrecognized storage selection.")
        }

    }
    
    // Add item to storage choice
    func addTodoItem(title: String, body: String) {
        itemsArray.append(Todo(title:  title, body: body, isComplete: false, timestamp: Date()))
        
        // Creates todo for a Core Data Object
        if storageChoice == .coreDataStorage {
            let newTodo = CoreDataTodo(context: context)
            newTodo.title = title
            newTodo.body = body
            newTodo.timestamp = Date()
        }
        saveTodoChangesToStorage()
    }
    
    // Load items based on storage choice
    func loadItems() {
        var savedData: [Todo]?
        
        switch storageChoice {
            case .defaultStorage:
                if let data = defaults.data(forKey: Constants.persistentStorage.arrayModels.todoListArray) {
                    do {
                        savedData = dataHandler.decodeTodoDataForJSON(for: data)
                        
                        if savedData != nil {
                            for item in savedData! {
                                if itemsArray.contains(where: {$0.id == item.id}) {
                                    print(logPrefix + "Item already in Todo array")
                                    continue
                                } else {
                                    itemsArray.append(item)
                                }
                            }
                        } else {
                            print(logPrefix + "Data returned is nil.")
                        }
                    }
                }
            case .pListStorage:
                if let data = try? Data(contentsOf: dataFilePath!) {
                    savedData = dataHandler.decodeTodoDataForPList(for: data)
                    itemsArray = savedData!
                }
            
            case .coreDataStorage:
                let request: NSFetchRequest<CoreDataTodo> = CoreDataTodo.fetchRequest()
                
                // Will return an array of CoreDataTodos.  Since multiple storage types are relying
                // on the same variable, CoreDataToods will be mapped to Todo.  This is unnecessary
                // in a circumstance where the CoreData Object Type is stored in the Array
                do {
                    print(logPrefix + "Fetching Todo List from Core Data")
                    let coreDataItemsArray = try context.fetch(request)
                    print(logPrefix + "Mapping Core Data List to Todo List")
                    for item in coreDataItemsArray {
                        let todo = Todo(
                            title: item.title ?? "Error loading Title",
                            body: item.body ?? "No description created",
                            isComplete: item.isComplete,
                            timestamp: item.timestamp ?? Date())
                        itemsArray.append(todo)
                    }
                    print(logPrefix + "Items mapped!")
                } catch {
                    print(logPrefix + "Error fetching Todo List from Core Data")
                }
                
            default:
                print(logPrefix + "Invalid storage selection to load items")

        }
    }
            
    func toggleCompleted(for todo: Todo) {
        if let selectedTodo = itemsArray.firstIndex(where: {$0.title == todo.title}) {
            
            itemsArray[selectedTodo].isComplete.toggle()
            print(logPrefix + "\(itemsArray[selectedTodo].title) has been marked \(itemsArray[selectedTodo].isComplete)")
            saveTodoChangesToStorage()
        } else {
            print(logPrefix + "Could not locate Todo to toggle completion")
                
        }
        
    }
}
    
    
    
    
    
    
    
    

