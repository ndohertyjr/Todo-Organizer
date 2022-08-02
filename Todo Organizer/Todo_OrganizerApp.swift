//
//  Todo_OrganizerApp.swift
//  Todo Organizer
//
//  Created by user220431 on 7/29/22.
//

import SwiftUI

@main
struct Todo_OrganizerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
