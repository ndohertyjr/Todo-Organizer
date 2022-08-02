//
//  TodoItemView.swift
//  Todo Organizer
//
//  Created by user220431 on 8/1/22.
//

import SwiftUI

struct TodoItemView: View {
    let todoTitle: String
    let todoDescription: String
    
    var body: some View {
        VStack {
            Text("\(todoTitle)")
                .font(.headline)
                .frame(minWidth: 50, idealWidth: 200, maxWidth: Constants.screenDimensions.screenWidth, minHeight: 100, idealHeight: 150, maxHeight: 200, alignment: .top)
            Section(content: {
            Divider()
            Text(todoDescription)
                .font(.body)
            }, header: {
                
                Text("Todo Description:")

            })
        }
        
    }
}

struct TodoItemView_Previews: PreviewProvider {
    static var previews: some View {
        TodoItemView(todoTitle: "Test", todoDescription: "Test Body")
    }
}
