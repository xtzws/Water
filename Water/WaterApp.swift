//
//  WaterApp.swift
//  Water
//
//  Created by Isaac Greene on 2024-01-01.
//

import SwiftUI

@main
struct WaterApp: App {
    var healthVM = HealthKitViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(healthVM)
        }
    }
}
