//
//  PListTodoListView.swift
//  Todo Organizer
//
//  Created by user220431 on 8/4/22.
//

import SwiftUI

struct PListTodoListView: View {
    @ObservedObject var todoListViewModel: PListTodoViewModel
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
                            PListTodoItemView(currentTodo: item, todoListViewModel: todoListViewModel)
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
            .environment(\.editMode, self.$editMode)
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
        PListAddTodo(showPopup: $showAddTodoPopup, todoListViewModel: todoListViewModel)
    }
        
}

struct PListTodoListView_Previews: PreviewProvider {
    static var previews: some View {
        PListTodoListView(todoListViewModel: PListTodoViewModel())
    }
}
