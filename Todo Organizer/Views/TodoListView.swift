//
//  TodoListView.swift
//  Todo Organizer
//
//  Created by user220431 on 7/29/22.
//

import SwiftUI


struct TodoListView: View {
    @ObservedObject var todoListViewModel: TodoListViewModel
    @State private var showAddTodoPopup: Bool = false
    @State private var selectedItem: Int?
    @State private var editMode: EditMode = .inactive
    @State private var isEditing = false
    @State private var newTodoText: String = ""

   
    
    var body: some View {
        ZStack {
            List(selection: $selectedItem) {
                Section{
                    ForEach(todoListViewModel.itemsArray, id: \.id) {item in
                        NavigationLink{
                            TodoItemView(todoTitle: item.title, todoDescription: item.body)
                        } label: {
                            HStack {
                                Label(item.title, systemImage: "doc.plaintext.fill")
                                .padding()
                            }
                            
                        }
                    }
                } header: {
                    Text("Todo Total: \(todoListViewModel.itemsArray.count)")
                }
                .listItemTint(.green)
            }
            .listStyle(.insetGrouped)
            .listRowSeparator(.visible)
            .navigationTitle(Constants.appName)
            .navigationBarTitleDisplayMode(.inline)
            .environment(\.editMode, self.$editMode.animation(.spring()))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        showAddTodoPopup.toggle()
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        print("Editing was \(isEditing)")
                        isEditing.toggle()
                        print("Editing is now \(isEditing)")
                        editMode = isEditing ? .active : .inactive
                        print("Edit mode is: \(editMode)")
                    }, label: {
                        Text("Edit")
                    })
                }
                    
            }
        }
        AddTodo(showPopup: $showAddTodoPopup, todoListViewModel: todoListViewModel)
    }
        
}
 


struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView(todoListViewModel: TodoListViewModel())
    }
}
