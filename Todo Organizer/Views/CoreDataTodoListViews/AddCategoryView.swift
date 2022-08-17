//
//  AddCategoryView.swift
//  Todo Organizer
//
//  Created by user225294 on 8/15/22.
//

import SwiftUI

struct AddCategoryView: View {
    @State private var categoryName: String = ""
    @ObservedObject var categoryViewModel: CategoryViewModel
    @Binding var showPopup: Bool
    var body: some View {
        if showPopup{
            ZStack {
                Color.yellow
                    
                VStack {
                    
                    Text("Enter the new category name:")
                    TextField(text: $categoryName) {
                        Text("Hello")
                            
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .background(RoundedRectangle(cornerRadius: 15)
                        .strokeBorder(Color.black))
                    .foregroundColor(Color.black)
                    .frame(width: Constants.screenDimensions.screenWidth * 0.7, height: Constants.screenDimensions.screenHeight / 10, alignment: .center)
            
        
                    Button {
                        categoryViewModel.addCategory(name: categoryName)
                        categoryName = ""
                        showPopup = false
                    } label: {
                        Text("Save!")
                    }

                }
                
            }
            .frame(width: Constants.screenDimensions.screenWidth * 0.8, height: Constants.screenDimensions.screenHeight * 0.3, alignment: .center
            )
            .cornerRadius(15).shadow(color: .black, radius: 10)
            
        }
        
    }
}

struct AddCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddCategoryView(categoryViewModel: CategoryViewModel(coreDataContext: PersistenceController.shared.container.viewContext), showPopup: .constant(true))
        
    }
}
