//
//  HealthKitViewModel.swift
//  Water
//
//  Created by Isaac Greene on 2024-01-07.
//

import Foundation
import HealthKit

class HealthKitViewModel: ObservableObject {
    private var healthStore = HKHealthStore()
    private var healthKitManager = HealthKitManager()
    @Published var userWaterAmount = ""
    @Published var isAuthorized = false
    
    init() {
        changeAuthorizationStatus()
    }
    
    func healthRequest() {
        healthKitManager.setUpHealthRequest(healthStore: healthStore) {
            self.changeAuthorizationStatus()
            self.readWaterTakenToday()
        }
    }
    
    func readWaterTakenToday() {
        healthKitManager.readWaterAmount(forToday: Date(), healthStore: healthStore) { ounce in
            if ounce != 0.0 {
                DispatchQueue.main.async {
                    self.userWaterAmount = String(format: "%.0f", ounce)
                }
            }
        }
    }
    
    func changeAuthorizationStatus() {
        guard let waterQtyType = HKObjectType.quantityType(forIdentifier: .dietaryWater) else { return }
        let status = self.healthStore.authorizationStatus(for: waterQtyType)
        
        switch status {
        case .notDetermined:
            isAuthorized = false
        case .sharingDenied:
            isAuthorized = false
        case .sharingAuthorized:
            isAuthorized = true
        @unknown default:
            isAuthorized = false
        }
    }
}
