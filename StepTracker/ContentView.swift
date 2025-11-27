//
//  ContentView.swift
//  StepTracker
//
//  Created by James Sweeney on 11/26/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State private var stepCount: Double
        = 0
    let healthStore = HealthStore()
    
    var body: some View {
        VStack {
            Text("Today's Steps")
                .font(.title)
            Text("\(Int(stepCount))")
                .bold()
                .font(.largeTitle)
            Button("Fetch Steps") {
                healthStore
                    .fetchStepCount {
                        steps in
                        stepCount = steps
                    }
            }
            .buttonStyle (
                .borderedProminent)
            .tint(.green)
        }
        .padding()
        .onAppear{
            requestHealthKitAccess()
                
            }
        }
         
        func requestHealthKitAccess() {
            healthStore.requestAuthorization {
                succes, error in
                if let error = error {
                    print("HealthKit auth failed")
                } else  {
                    print("HealthKit was successful")
                }
            }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
