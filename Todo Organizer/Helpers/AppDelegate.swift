//
//  AppDelegate.swift
//  Todo Organizer
//
//  Created by Neil Doherty on 8/2/22.
//

import Foundation
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        print("Simulator directory:")
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
        print("Current user defaults:")
        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
            print("\(key) = \(value)")
        }
        return true
    }
}
