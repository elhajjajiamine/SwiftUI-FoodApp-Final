//
//  SwiftUI_FoodAppApp.swift
//  SwiftUI FoodApp
//
//  Created by elhajjaji on 10/28/20.
//

import SwiftUI
import Firebase
import UIKit

@main
struct SwiftUI_FoodAppApp: App {
    // Create a reference to the App Delegate
        @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

//initializing firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Configure FirebaseApp
        FirebaseApp.configure()
        return true
    }
}
