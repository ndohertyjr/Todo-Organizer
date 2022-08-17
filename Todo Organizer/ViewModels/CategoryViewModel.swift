//
//  CategoryViewModel.swift
//  Todo Organizer
//
//  Created by user225294 on 8/15/22.
//

import Foundation
import CoreData

class CategoryViewModel: ObservableObject {
    
    let logPrefix: String = "[CategoryViewModel]"
    @Published var categoryArray = [Category]()
    let context: NSManagedObjectContext
    
    
    init(coreDataContext context: NSManagedObjectContext) {
        self.context = context
        loadCategories()
    }
    
    // MARK: Save changes from context
    func saveChangesToCoreData() {
        do{
            print("\(logPrefix) Saving changes to db")
            try context.save()
        } catch {
            print("\(logPrefix) Error saving changes to db. Error: \(error)")
        }
        
    }
    
    // MARK: Create new category
    func addCategory(name: String) {
        let newCategory = Category(context: context)
        newCategory.name = name
        
        saveChangesToCoreData()
        loadCategories()
        
    }
    
    
    // MARK: Read categories
    func loadCategories() {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            print("\(logPrefix) Loading Categories from Core Data...")
            
            if try context.count(for: request) == 0 {
                categoryArray = []
            }
            else {
                categoryArray = try context.fetch(request)
            }
        } catch {
            print("Error loading categories. Error: \(error)")
        }
    }
    
    // MARK: Delete Category
}
