//
//  StepTrackerApp.swift
//  StepTracker
//
//  Created by James Sweeney on 11/26/25.
//

import SwiftUI

@main
struct StepTrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
