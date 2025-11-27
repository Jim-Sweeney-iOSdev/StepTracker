//
//  ContentView.swift
//  StepTracker
//
//  Created by James Sweeney on 11/26/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    var body: some View {
        Text("hello world")
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
