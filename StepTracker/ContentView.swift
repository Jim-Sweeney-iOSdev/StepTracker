//
//  ContentView.swift
//  StepTracker
//
//  Created by James Sweeney on 11/26/25.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @State private var stepCount: Double = 0
    let healthStore = HealthStore()
    @State private var animateNumber = false
    
    // Your custom accent color
    let accent = Color(red: 0.392, green: 0.706, blue: 0.863) // #64b4dc

    var body: some View {
        ZStack {
            // Background Gradient
            LinearGradient(
                       colors: [
                           accent.opacity(0.4),
                           accent.opacity(0.9)
                       ],
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing
                   )
            .ignoresSafeArea()

            VStack(spacing: 32) {

                // --- LUMON LOGO ---
                Image("lumonlogo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .padding(.top, 20)
                    .shadow(radius: 10)

                // Frosted glass card
                VStack(spacing: 16) {
                    Text("Innie Steps")
                        .font(.system(size: 32, weight: .semibold))
                        .foregroundColor(.white)

                    // Animated step number
                    Text("\(Int(stepCount))")
                        .font(.system(size: 64, weight: .black, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(color: accent.opacity(0.5), radius: 14)
                        .scaleEffect(animateNumber ? 1.1 : 1.0)
                        .animation(.easeOut(duration: 0.25), value: stepCount)
                }
                .padding(40)
                .background(.ultraThinMaterial)
                .cornerRadius(30)
                .shadow(radius: 20)

                // Fetch button
                Button {
                    healthStore.fetchStepCount { steps in
                        withAnimation {
                            stepCount = steps
                            animateNumber.toggle()
                        }
                    }
                } label: {
                    HStack {
                        Image(systemName: "figure.walk")
                        Text("Fetch My Innie's Steps")
                    }
                    .font(.title3.bold())
                    .padding()
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(accent)
                .padding(.horizontal)

                Spacer()
            }
            .padding(.top, -60)
        }
        .onAppear {
            requestHealthKitAccess()
        }
    }

    func requestHealthKitAccess() {
        healthStore.requestAuthorization { success, error in
            if let error = error {
                print("HealthKit authorization failed: \(error.localizedDescription)")
            } else {
                print("HealthKit authorized")
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
