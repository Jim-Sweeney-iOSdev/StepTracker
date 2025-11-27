//
//  HealthStore.swift
//  StepTracker
//
//  Created by James Sweeney on 11/26/25.
//


import HealthKit

class HealthStore {
    let healthStore = HKHealthStore()
    
    // request permission
    
    func requestAuthorization(completion: @escaping(Bool, Error?)-> Void) {
        let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
        let calorieType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!
        
        let typesToRead: Set = [stepCountType, heartRateType, calorieType]
        
        healthStore.requestAuthorization(toShare: [], read: typesToRead) {
            succes, error in
            completion(succes, error)
        }
    }
    
    func fetchStepCount(completion: @escaping(Double)-> Void) {
        let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let startDate = Calendar.current.startOfDay(for: Date()) // todays date
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(),
        options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum) {
            _, result, _ in
            let stepCount = result?.sumQuantity()?.doubleValue(for: .count()) ?? 0
            DispatchQueue.main.async {
                completion(stepCount)
            }
        }
        healthStore.execute(query)
        
    }
}
