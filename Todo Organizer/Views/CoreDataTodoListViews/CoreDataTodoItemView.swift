//
//  CoreDataTodoListView.swift
//  Todo Organizer
//
//  Created by user220431 on 8/4/22.
//

import SwiftUI
import CoreData

struct CoreDataTodoItemView: View {
    let logPrefix = "[CoreDataTodoItemView] "
    let currentTodo: CoreDataTodo
    let todoListViewModel: CoreDataTodoViewModel
    
    var body: some View {
        VStack {
            Section(content: {
                Text("\(currentTodo.title!)")
                    .font(.system(size: 40))
                    .padding(10)
                    .frame(minWidth: 50, idealWidth: 200, maxWidth: Constants.screenDimensions.screenWidth, minHeight: 100, idealHeight: 150, maxHeight: 200, alignment: .center)
                Divider()
            })
            Section(content: {
                Text(currentTodo.body ?? "Description failed to load")
                .font(.body)
            })
            Spacer()
            Section(content: {
                Button(action: {
                    todoListViewModel.toggleCompleted(for: currentTodo)
                }, label: {
                    RoundedRectangle(cornerRadius: 50)
                        .overlay(Text(currentTodo.isComplete ? "Completed!" : "Press to mark completed.")
                            .font(.body)
                            .foregroundColor(.black)
                            )
                        .frame(maxWidth: .infinity, maxHeight: Constants.screenDimensions.screenHeight / 10)
                })
                .padding()
                .foregroundColor(currentTodo.isComplete ? .green : .red)
                .shadow(color: .black, radius: 10, x: 10, y: 10)
            })
        }
        
    }
}
struct CoreDataTodoListView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.shared.container.viewContext
        let item = CoreDataTodo(context: context)
        item.title = "Test Item"
        item.body = "Test description"
        item.isComplete = false
        item.timestamp = Date()
     
        return CoreDataTodoItemView(currentTodo: item, todoListViewModel: CoreDataTodoViewModel(coreDataContext: context))
            .environment(\.managedObjectContext, context)
    }
}
