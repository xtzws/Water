//
//  HealthKitManager.swift
//  Water
//
//  Created by Isaac Greene on 2024-01-06.
//

import Foundation
import HealthKit

class HealthKitManager: ObservableObject {
    
    func setUpHealthRequest(healthStore: HKHealthStore, readWater: @escaping () -> Void) {
        if HKHealthStore.isHealthDataAvailable(), let dietWater = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryWater) {
            healthStore.requestAuthorization(toShare: [dietWater], read: [dietWater]) { success, error in
                if success {
                    readWater()
                } else if error != nil {
                    print (error ?? "Error")
                }
            }
        }
    }
    
    func readWaterAmount(forToday: Date, healthStore: HKHealthStore, completion: @escaping (Double) -> Void) {
        guard let waterQuantityType = HKQuantityType.quantityType(forIdentifier: .dietaryWater) else { return }
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: waterQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
            
            guard let result = result, let sum = result.sumQuantity() else {
                completion(0.0)
                return
            }
            
            completion(sum.doubleValue(for: HKUnit.count()))
        
        }
        
        healthStore.execute(query)
        
    }
}
