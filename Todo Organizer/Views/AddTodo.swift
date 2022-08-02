//
//  AddTodo.swift
//  Todo Organizer
//
//  Created by user220431 on 8/1/22.
//

import SwiftUI

struct AddTodo: View {
    
    enum Field: Hashable {
        case addTodoTitle
        case addTodoBody
       
    }
    
    @Binding var showPopup: Bool
    @State private var addTodoTitle: String = ""
    @State private var addTodoBody: String = ""
    @FocusState private var focusedField: Field?
    @ObservedObject var todoListViewModel: TodoListViewModel
    

    var body: some View {
        ZStack(alignment: .center) {
            if showPopup {
                Color.black.opacity(showPopup ? 1.0 : 0).edgesIgnoringSafeArea(.all)
                VStack(alignment: .center, spacing: 0) {
                    Form {
                        Section(header: Text("Add Todo!")
                            .frame(maxWidth: .infinity, maxHeight: 20, alignment: .center)
                            .foregroundColor(Color.black)
                            .font(.largeTitle)
                            
                            .padding()
                        ) {
                            TextField(text: $addTodoTitle) {
                                Text("Todo Title:")
                            }
                            .focused($focusedField, equals: .addTodoTitle)
                            .padding()
                
                            TextField(text: $addTodoBody) {
                                Text("Todo Description:")
                            }
                            .focused($focusedField, equals: .addTodoBody)
                            .padding()
                        }
                       
                    }
                    .border(Color.green, width: 2)
                    HStack {
                    Button(action: {
                        if addTodoTitle.isEmpty {
                            focusedField = .addTodoTitle
                            print("title missing")
                        }
                        else if addTodoBody.isEmpty {
                            focusedField = .addTodoBody
                            print("body missing")
                        } else {
                            print("Saved!")
                            withAnimation(.linear(duration: 0.3)) {
                                todoListViewModel.addTodoItem(title: addTodoTitle, body: addTodoBody)
                                clearTodoItem()
                                showPopup = false
                            }
                        }
                        
                    }, label: {
                        Text("Save")
                            .frame( alignment: .center
                            )
                    })
                    .buttonStyle(PlainButtonStyle())
                    .border(Color.black, width: 1)
        
                    .frame(width: 200, height: 50, alignment: .center)
                 
                    Button(action: {
                        print("Quit")
                        withAnimation(.linear(duration: 0.3)) {
                            clearTodoItem()
                            showPopup = false
                        }
                    }, label: {
                        Text("Quit")
                    })
                    .buttonStyle(PlainButtonStyle())
                    .border(Color.black, width: 1)
                    .frame(width: 200, height: 20, alignment: .center)
                    }
                }
                .frame(width: UIScreen.main.bounds.width - 10, height: UIScreen.main.bounds.height / 2, alignment: .center)
               
                .background(Color.gray)
            }
        }
        //.frame(width: Constants.screenDimensions.screenWidth, height: Constants.screenDimensions.screenHeight, alignment: .center)
    }
    
    func clearTodoItem() {
        addTodoTitle = ""
        addTodoBody = ""
    }
}

struct AddTodo_Previews: PreviewProvider {

    static var previews: some View {
        AddTodo(showPopup: .constant(true), todoListViewModel: TodoListViewModel())
    }
}