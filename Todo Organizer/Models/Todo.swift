//
//  Todo.swift
//  Todo Organizer
//
//  Created by user220431 on 7/29/22.
//

import Foundation

// Necessary when testing using UserDefault or P List storage
// See TodoDataModel for Core Data compatible model
struct Todo: Identifiable, Hashable, Codable {
    private(set) var id = UUID()
    let title: String
    let body: String
    var isComplete: Bool
    let timestamp: Date
}
