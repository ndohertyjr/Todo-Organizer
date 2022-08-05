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
                    CoreDataTodoListViews(todoListViewModel: CoreDataTodoViewModel(coreDataContext: context))
                } label: {
                    Label("Core Data", systemImage: "tablecells")
                }

            }
        }
        
    }
//
//    @ViewBuilder
//    func viewSelectorForStorage() -> some View {
//        switch currentSelection {
//            case .userDefault:
//                UserDefaultTodoListView(todoListViewModel: UserDefaultTodoViewModel())
//            case .pList:
//                PListTodoListView(todoListViewModel: PListTodoViewModel())
//            case .coreData:
//                CoreDataTodoListViews(todoListViewModel: CoreDataTodoViewModel(coreDataContext: context))
//        }
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

