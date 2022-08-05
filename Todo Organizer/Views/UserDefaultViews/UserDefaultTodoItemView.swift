//
//  TodoItemView.swift
//  Todo Organizer
//
//  Created by user220431 on 8/1/22.
//

import SwiftUI

struct UserDefaultTodoItemView: View {
    let currentTodo: Todo
    let todoListViewModel: UserDefaultTodoViewModel
    
    var body: some View {
        VStack {
            Section(content: {
                Text("\(currentTodo.title)")
                    .font(.system(size: 40))
                    .padding(10)
                    .frame(minWidth: 50, idealWidth: 200, maxWidth: Constants.screenDimensions.screenWidth, minHeight: 100, idealHeight: 150, maxHeight: 200, alignment: .center)
                Divider()
            })
            Section(content: {
                Text(currentTodo.body)
                .font(.body)
            })
            Spacer()
            Section(content: {
                Button(action: {
                    todoListViewModel.toggleCompleted(for: currentTodo)
                }, label: {
                    RoundedRectangle(cornerRadius: 50)
                        .overlay(Text(currentTodo.isComplete ? "Completed!" : "Press to mark completed.")
                            .font(.body)
                            .foregroundColor(.black)
                            )            
                        .frame(maxWidth: .infinity, maxHeight: Constants.screenDimensions.screenHeight / 10)
                })
                .padding()
                .foregroundColor(currentTodo.isComplete ? .green : .red)
                .shadow(color: .black, radius: 10, x: 10, y: 10)
            })
        }
        
    }
}

struct TodoItemView_Previews: PreviewProvider {
    static var previews: some View {
        UserDefaultTodoItemView(currentTodo: Todo(title: "Test", body: "Test body", isComplete: false, timestamp: Date()), todoListViewModel: UserDefaultTodoViewModel())
    }
}
