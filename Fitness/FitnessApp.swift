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
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            if appState.isLoggedIn {
                TabView {
                    Text("Log")
                        .tabItem {
                            Image(systemName: "book")
                        }
                }.accentColor(.primary)
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
        try? Auth.auth().signOut()
        
        userService
            .observeAuthChanges()
            .map { $0 != nil }
            .assign(to: &$isLoggedIn)
    }
}
