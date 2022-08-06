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

class UserDefaultTodoViewModel: ObservableObject {
    let logPrefix = "[UserDefaultTodoListViewModel] "
    
    @Published var itemsArray = [Todo]()
    // Helper functions for encoding/decoding data
    let dataHandler = DataHandler()
    
    let defaults = UserDefaults.standard
    
    
    init() {
        addTodoItem(title: "This is your todo list!", body: "Write details of your todo here.")
        loadData()
    }
    
    // MARK: Save Changes Section
    func saveTodoChangesToStorage() {
        // Custom object encoded to store to defaults
        if let safeData = dataHandler.encodeTodoDataForJSON(for: itemsArray) {
            defaults.set(safeData, forKey: Constants.persistentStorage.arrayModels.todoListArray)
        }
        else {
            print(logPrefix + "Error adding todo to list!  Data not encoded correctly.")
        }
    }
    
    // MARK: Create Item Section
    // Add item to storage choice
    func addTodoItem(title: String, body: String) {
        itemsArray.append(Todo(title:  title, body: body, isComplete: false, timestamp: Date()))
        saveTodoChangesToStorage()
        
    }
    
    // MARK: Read Items Section
    // Load items based on storage choice
    func loadData() {
        var savedData: [Todo]?
        if let data = defaults.data(forKey: Constants.persistentStorage.arrayModels.todoListArray) {
            do {
                if data.isEmpty {
                    itemsArray = []
                    print(logPrefix + "ItemsArray is empty")
                } else {
                    savedData = dataHandler.decodeTodoDataForJSON(for: data)!
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
        }
        
    }
    
    // MARK: Update Item Section
    func toggleCompleted(for todo: Todo) {
        if let selectedTodo = itemsArray.firstIndex(where: {$0.title == todo.title}) {
            itemsArray[selectedTodo].isComplete.toggle()
            print(logPrefix + "\(itemsArray[selectedTodo].title) has been marked \(itemsArray[selectedTodo].isComplete)")
            saveTodoChangesToStorage()
        } else {
            print(logPrefix + "Could not locate Todo to toggle completion")
            
        }
    }
    
    // MARK: Delete Item Section
    func deleteItem(for todoIndex: Int) {
        itemsArray.remove(at: todoIndex)
        saveTodoChangesToStorage()
        loadData()
    }    
}









