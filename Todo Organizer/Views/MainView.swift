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
                TodoListView(todoListViewModel: TodoListViewModel(coreDataContext: context))
            }
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

