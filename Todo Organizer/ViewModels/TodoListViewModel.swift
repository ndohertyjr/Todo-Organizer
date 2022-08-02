//
//  MainViewModel.swift
//  Todo Organizer
//
//  Created by user220431 on 7/29/22.
//

import Foundation

class TodoListViewModel: ObservableObject {
    
    @Published var itemsArray = [Todo]()
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    let defaults = UserDefaults.standard
    
    init() {
        itemsArray = []
        
            
    }
    
    func addTodoItem(title: String, body: String) {
        itemsArray.append(Todo(title:  "Test", body: "Body!"))
        
        encodeTodoData(itemsArray)
        //defaults.set(itemsArray, forKey: "TodoListArray")
    }
    
    // Needed to save custom object to UserDefaults
    func encodeTodoData(_ dataToConvert: [Todo]) -> Data? {
        var encodedData: Data?
        do {
            try encodedData = encoder.encode(dataToConvert)
        } catch  {
            print("Error encoding data")
        }
        
        return encodedData!
    }
    
    func decodeTodoData() -> [Todo]{
        
    }
    
    
}
