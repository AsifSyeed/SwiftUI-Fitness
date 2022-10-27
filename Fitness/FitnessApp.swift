//
//  FitnessApp.swift
//  Fitness
//
//  Created by BS901 on 10/20/22.
//

import SwiftUI
import Firebase

@main
struct FitnessApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var appState = AppState()
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            if appState.isLoggedIn {
                TabContainerView()
                    .preferredColorScheme(isDarkMode ? .dark : .light)
            } else {
                LandingView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
        return true
    }
}

class AppState: ObservableObject {
    @Published private(set) var isLoggedIn = false
    
    private let userService: UserServiceProtocol
    
    init(userService: UserServiceProtocol = UserService()) {
        self.userService = userService
        
        userService
            .observeAuthChanges()
            .map { $0 != nil }
            .assign(to: &$isLoggedIn)
    }
}
