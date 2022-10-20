//
//  FitnessApp.swift
//  Fitness
//
//  Created by BS901 on 10/20/22.
//

import SwiftUI

@main
struct FitnessApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            LandingView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
