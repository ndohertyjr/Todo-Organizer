//
//  TodoListView.swift
//  Todo Organizer
//
//  Created by user220431 on 7/29/22.
//

import SwiftUI


struct UserDefaultTodoListView: View {
    @ObservedObject var todoListViewModel: UserDefaultTodoViewModel
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
                    ForEach(todoListViewModel.itemsArray, id: \.id) {item in
                        NavigationLink{
                            UserDefaultTodoItemView(currentTodo: item, todoListViewModel: todoListViewModel)
                        } label: {
                            HStack {
                                Image(systemName: item.isComplete ? "checkmark" : "doc.plaintext.fill")
                                    .foregroundColor(item.isComplete ? .green : .red)
                                    .padding(3)
                                Text(item.title)
                                    .font(.system(size: 24))
                                .padding()
                            }
                            
                        }
                    }
                    .contextMenu {
                        Button {
                            print("Delete Item")
                        } label: {
                            Text("Delete me")
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
            // FIXME: Edit button not working
            .environment(\.editMode, .constant(.active))
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
        UserDefaultAddTodo(showPopup: $showAddTodoPopup, todoListViewModel: todoListViewModel)
    }
        
}
 


struct UserDefaultTodoListView_Previews: PreviewProvider {
    static var previews: some View {
        UserDefaultTodoListView(todoListViewModel: UserDefaultTodoViewModel())
    }
}
