//
//  PListTodoViewModel.swift
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

class PListTodoViewModel: ObservableObject {
    let logPrefix = "[UserDefaultTodoListViewModel] "
    @Published var itemsArray = [Todo]()
    let dataFilePath = Constants.persistentStorage.dataFilePath
    
    // Helper functions for encoding/decoding data
    let dataHandler = DataHandler()
    
    init() {
        addTodoItem(title: "This is your todo list!", body: "Write details of your todo here.")
        loadData()
    }
    
    //Custom object encoded to store to pList
    func saveTodoChangesToStorage() {
        if let safeData = dataHandler.encodeTodoDataForPList(for: itemsArray) {
            do {
                try safeData.write(to: dataFilePath!)
                print(logPrefix + "Saved to Property List")
            } catch {
                print(logPrefix + "Failed to add todo item to Property List")
            }
        }
    }
    
    // MARK: Create Item Section
    func addTodoItem(title: String, body: String) {
        itemsArray.append(Todo(title:  title, body: body, isComplete: false, timestamp: Date()))
        saveTodoChangesToStorage()
    }
    
    // MARK: Read Items Section
    func loadData() {
        var savedData: [Todo]?
        if let data = try? Data(contentsOf: dataFilePath!) {
            if data.isEmpty {
                itemsArray = []
            } else {
                savedData = dataHandler.decodeTodoDataForPList(for: data)
                itemsArray = savedData!
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
