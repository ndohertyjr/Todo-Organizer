//
//  ContentView.swift
//  Todo Organizer
//
//  Created by Neil Doherty on 7/29/22.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                TodoListView(todoListViewModel: TodoListViewModel())
            }
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

