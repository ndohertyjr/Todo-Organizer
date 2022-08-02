//
//  Todo.swift
//  Todo Organizer
//
//  Created by user220431 on 7/29/22.
//

import Foundation

struct Todo: Identifiable, Hashable, Codable {
    private(set) var id = UUID()
    let title: String
    let body: String
    var isComplete: Bool
}
