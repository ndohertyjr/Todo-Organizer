//
//  PListTodoListView.swift
//  Todo Organizer
//
//  Created by Neil Doherty on 8/4/22.
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
    @State private var searchText: String = ""
    
    
    var body: some View {
        ZStack {
            VStack {
                Divider()
                ZStack{
                    Rectangle()
                        .foregroundColor(Color(red: 220, green: 220, blue: 220))
                        .cornerRadius(13)
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("Search", text: $searchText)
                    }
                    .foregroundColor(.gray)
                    .padding(.leading, 13)
                }
                .frame(maxWidth: .infinity, maxHeight: Constants.screenDimensions.screenHeight / 14, alignment: .top)
                List(selection: $selectedItem) {
                    Section{
                        ForEach(todoListViewModel.itemsArray.indices, id: \.self) {index in
                            NavigationLink{
                                PListTodoItemView(currentTodo: todoListViewModel.itemsArray[index], todoListViewModel: todoListViewModel)
                            } label: {
                                HStack {
                                    Image(systemName: todoListViewModel.itemsArray[index].isComplete ? "checkmark" : "doc.plaintext.fill")
                                        .foregroundColor(todoListViewModel.itemsArray[index].isComplete ? .green : .red)
                                        .padding(3)
                                    Text(todoListViewModel.itemsArray[index].title)
                                        .font(.system(size: 24))
                                        .padding()
                                }
                                .contextMenu {
                                    Button {
                                        todoListViewModel.deleteItem(for: index)
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
                .navigationTitle(Constants.appName + " - Property List")
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
    
}

struct PListTodoListView_Previews: PreviewProvider {
    static var previews: some View {
        PListTodoListView(todoListViewModel: PListTodoViewModel())
    }
}
