//
//  CoreDataTodoListViews.swift
//  Todo Organizer
//
//  Created by user220431 on 8/4/22.
//

import SwiftUI

struct CoreDataTodoListViews: View {
    @ObservedObject var todoListViewModel: CoreDataTodoViewModel
    @State private var showAddTodoPopup: Bool = false
    @State private var selectedItem: Int?
    @State private var editMode: EditMode = .inactive
    @State private var isEditing = false
    @State private var newTodoText: String = ""
    @State private var deleteIsHovered: Bool = false
    

    var body: some View {
        ZStack {
            List(selection: $selectedItem) {
                Section{
                    ForEach(todoListViewModel.itemsArray.indices, id:\.self) {index in
                        NavigationLink{
                            CoreDataTodoItemView(currentTodo: todoListViewModel.itemsArray[index], todoListViewModel: todoListViewModel)
                        } label: {
                            HStack {
                                Image(systemName: todoListViewModel.itemsArray[index].isComplete ? "checkmark" : "doc.plaintext.fill")
                                    .foregroundColor(todoListViewModel.itemsArray[index].isComplete ? .green : .red)
                                    .padding(3)
                                Text(todoListViewModel.itemsArray[index].title!)
                                    .font(.system(size: 24))
                                .padding()
                            }
                            .contextMenu {
                                Button {
                                    todoListViewModel.deleteItem(at: index)
                                } label: {
                                    Text("Delete me")
                                }
                            }
                        }
                    }
                    
                } header: {
                    Text("Todo Total: \(todoListViewModel.itemsArray.count)")
                }
                //.listItemTint(item.isComplete ? .green : .red)
            }
            .listStyle(.insetGrouped)
            .listRowSeparator(.visible)
            .navigationTitle(Constants.appName)
            .navigationBarTitleDisplayMode(.inline)
            .environment(\.editMode, $editMode)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
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
        CoreDataAddTodo(showPopup: $showAddTodoPopup, todoListViewModel: todoListViewModel)
    }
        
}
struct CoreDataTodoListViews_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataTodoListViews(todoListViewModel: CoreDataTodoViewModel(coreDataContext: PersistenceController.shared.container.viewContext))
    }
}
