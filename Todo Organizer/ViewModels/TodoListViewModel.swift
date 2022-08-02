//
//  MainViewModel.swift
//  Todo Organizer
//
//  Created by user220431 on 7/29/22.
//

import Foundation

class TodoListViewModel: ObservableObject {
    
    @Published var itemsArray = [Todo]()
    let dataHandler = DataHandler()
    let defaults = UserDefaults.standard
    
    init() {
        itemsArray = []
        getSavedTodoList()
            
    }
    
    func addTodoItem(title: String, body: String) {
        itemsArray.append(Todo(title:  title, body: body))
        // Custom object encoded to store to defaults
        if let safeData = dataHandler.encodeTodoData(for: itemsArray) {
            
            defaults.set(safeData, forKey: Constants.persistentStorage.userDefaults.todoListArray)
        }
        else {
            print("Error adding todo to list!  Data not encoded correctly.")
        }
        
    }
    
    func getSavedTodoList(){
        var savedData: [Todo]?
        
        if let data = defaults.data(forKey: Constants.persistentStorage.userDefaults.todoListArray) {
            do {
                savedData = try dataHandler.decodeTodoData(for: data)
                
                if savedData != nil {
                    itemsArray = savedData!
                } else {
                    print("Data returned is nil.")
                }
            } catch {
                print("Error retrieving saved Todo List. \(error)")
            }
        }
        
    }
    
    
    
    
    
    
    
    
}
