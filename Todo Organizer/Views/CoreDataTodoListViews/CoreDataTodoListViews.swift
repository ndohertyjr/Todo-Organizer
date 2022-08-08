//
//  CoreDataTodoListViews.swift
//  Todo Organizer
//
//  Created by Neil Doherty on 8/4/22.
//

import SwiftUI

struct CoreDataTodoListViews: View {
    let logPrefix = "[CoreDataTodoListViews] "
    @ObservedObject var todoListViewModel: CoreDataTodoViewModel
    @State private var showAddTodoPopup: Bool = false
    @State private var selectedItem: Int?
    @State private var editMode: EditMode = .inactive
    @State private var isEditing = false
    @State private var newTodoText: String = ""
    @State private var deleteIsHovered: Bool = false
    @State private var searchText: String = ""
    @State private var filteredTodos: [String] = []
    @Environment(\.isSearching) private var isSearching: Bool
    @Environment(\.dismissSearch) private var dismissSearch
  
    
    
    var body: some View {
        ZStack {
            VStack {
                Divider()
                List(selection: $selectedItem) {
                    Section{
                        ForEach(todoListViewModel.itemsArray.indices, id:\.self) {index in
                            NavigationLink{
                                CoreDataTodoItemView(todo: todoListViewModel.itemsArray[index], viewModel: todoListViewModel)
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
                .navigationTitle(Constants.appName + " - Core Data")
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
                .searchable(text: $searchText) {
                    Text("These todos match your search:")
                    ForEach(filteredTodos, id:\.self) { item in
                        Text("\(item)").searchCompletion(item)
                    }
                }
                .onSubmit(of: .search) {
                    
                    todoListViewModel.searchTodosByTitle(searchText)
                }
                
                
                
            }
            
            CoreDataAddTodo(showPopup: $showAddTodoPopup, todoListViewModel: todoListViewModel)
        }
    }
}

extension CoreDataTodoListViews {
    func filterSearch() {
        filteredTodos = []
        for item in todoListViewModel.itemsArray {
            print("Appending \(item) due to empty search Text")
            filteredTodos.append(item.title!)
        }
        if searchText.isEmpty {
            print(logPrefix + "Search field is empty")
        } else {
            filteredTodos = filteredTodos.filter {
                $0.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}

struct CoreDataTodoListViews_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataTodoListViews(todoListViewModel: CoreDataTodoViewModel(coreDataContext: PersistenceController.shared.container.viewContext))
    }
}
