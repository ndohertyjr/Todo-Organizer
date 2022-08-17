//
//  ContentView.swift
//  Todo Organizer
//
//  Created by Neil Doherty on 7/29/22.
//

import SwiftUI


struct MainView: View {
    @Environment(\.managedObjectContext) var context
    
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Choose your data storage option:")
                NavigationLink {
                    UserDefaultTodoListView(todoListViewModel: UserDefaultTodoViewModel())
                } label: {
                    Label("User Defaults", systemImage: "externaldrive")
                }
                NavigationLink {
                    PListTodoListView(todoListViewModel: PListTodoViewModel())
                } label: {
                    Label("Property List", systemImage: "list.bullet.rectangle.portrait")
                }
                NavigationLink {
                    CoreDataCategoryView(todoListViewModel: CoreDataTodoViewModel(coreDataContext: context), categoryListViewModel: CategoryViewModel(coreDataContext: context))
                } label: {
                    Label("Core Data", systemImage: "tablecells")
                }
                
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

