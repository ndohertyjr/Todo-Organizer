//
//  Constants.swift
//  Todo Organizer
//
//  Created by user220431 on 7/29/22.
//

import Foundation
import UIKit

struct Constants {
    static let appName = "Todo Organizer"
    
    struct alerts {
        static let addTodo = "addTodo"
        static let deleteTodo = "deleteTodo"
        static let editTodo = "editTodo"
    }
    
    struct screenDimensions {
        static let screenHeight = UIScreen.main.bounds.height
        static let screenWidth = UIScreen.main.bounds.width
    }
    
    struct persistentStorage {
        static let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
        
        struct arrayModels {
            static let todoListArray = "TodoListArray"
        }
    }
}
