//
//  MainViewModel.swift
//  Todo Organizer
//
//  Created by user220431 on 7/29/22.
//

import Foundation

/*
    ViewModel to handle the data for the TodoList Views.
    Shows different potential options for storing data in persistent storage.
*/

class TodoListViewModel: ObservableObject {
    
    @Published var itemsArray = [Todo]()
    let dataHandler = DataHandler()
    
    // Storage options
    let defaults = UserDefaults.standard
    let dataFilePath = Constants.persistentStorage.dataFilePath
    
    // Storage options
    enum StorageSelection {
        case defaultStorage
        case pListStorage
    }
    var storageChoice = StorageSelection.pListStorage
    
    let logPrefix = "[TodoListViewModel] "
    
    init() {
        itemsArray = [Todo(title: "Your Todo Title Here", body: "Detailed description of what you want to accomplish.", isComplete: false)]
        getSavedTodoList()
            
    }
    
    func addTodoItem(title: String, body: String) {
        itemsArray.append(Todo(title:  title, body: body, isComplete: false))
        
       
        // Uses storage selection
        switch storageChoice {
            // Custom object encoded to store to defaultsa
            case .defaultStorage:
                if let safeData = dataHandler.encodeTodoDataForJSON(for: itemsArray) {
                    defaults.set(safeData, forKey: Constants.persistentStorage.arrayModels.todoListArray)
                }
                else {
                    print(logPrefix + "Error adding todo to list!  Data not encoded correctly.")
                }
            case .pListStorage:
                if let safeData = dataHandler.encodeTodoDataForPList(for: itemsArray) {
                    do {
                        try safeData.write(to: dataFilePath!)
                    } catch {
                        print(logPrefix + "Failed to add todo item to Property List")
                    }
                    
                }
            default:
                print(logPrefix + "Unrecognized storage selection.")
        }
    }
    
    func getSavedTodoList(){
        var savedData: [Todo]?
        
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
    }
        
    func toggleCompleted(for todo: Todo) {
        if let selectedTodo = itemsArray.firstIndex(where: {$0.title == todo.title}) {
            
            itemsArray[selectedTodo].isComplete.toggle()
            
            print(logPrefix + "\(itemsArray[selectedTodo].title) has been marked \(itemsArray[selectedTodo].isComplete)")
        } else {
            print(logPrefix + "Could not locate Todo to toggle completion")
                
        }
    }
}
    
    
    
    
    
    
    
    

