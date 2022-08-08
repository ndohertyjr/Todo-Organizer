//
//  Todo_OrganizerApp.swift
//  Todo Organizer
//
//  Created by Neil Doherty on 7/29/22.
//

import SwiftUI

@main
struct Todo_OrganizerApp: App {
    let logPrefix = "[Todo_OrganizerApp] "
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let persistenceController = PersistenceController.shared
    
    // Monitors app for scene change to save changes
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                
        }
        .onChange(of: scenePhase) { newPhase in
            print(logPrefix + "App scene changed to \(newPhase)")
            persistenceController.save()
            
        }
    }
}
