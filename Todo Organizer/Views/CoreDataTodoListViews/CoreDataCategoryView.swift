//
//  CoreDataCategoryView.swift
//  Todo Organizer
//
//  Created by user225294 on 8/15/22.
//

import SwiftUI

struct CoreDataCategoryView: View {
    @ObservedObject var todoListViewModel: CoreDataTodoViewModel
    @ObservedObject var categoryListViewModel: CategoryViewModel
    @State private var showAddCategory = false
    
    var body: some View {
        ZStack{
            VStack {
                Text("Hello, choose a category below")
                List {
                    ForEach(categoryListViewModel.categoryArray.indices, id: \.self) { index in
                        NavigationLink {
                            CoreDataTodoListViews(todoListViewModel: todoListViewModel)
                        } label: {
                            Text(categoryListViewModel.categoryArray[index].name!)
                        }
                    }
                }
                
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showAddCategory = true
                        } label: {
                            Image(systemName: "plus")
                            
                        }

                    }
                }
            }
            AddCategoryView(categoryViewModel: categoryListViewModel, showPopup: $showAddCategory)
        }
        
    }
}

struct CoreDataCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataCategoryView(todoListViewModel: CoreDataTodoViewModel(coreDataContext: PersistenceController.shared.container.viewContext), categoryListViewModel: CategoryViewModel(coreDataContext: PersistenceController.shared.container.viewContext))
    }
}
