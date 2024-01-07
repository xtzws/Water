//
//  ContentView.swift
//  Water
//
//  Created by Isaac Greene on 2024-01-01.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var hkvm: HealthKitViewModel
    
    var body: some View {
        VStack {
            if hkvm.isAuthorized {
                VStack {
                    Text("Today's Water Consumed")
                        .font(.title3)
                    
                    Text("\(hkvm.userWaterAmount)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
            } else {
                VStack {
                    Text("Please Authorize Health!")
                        .font(.title3)
                    
                    Button {
                        hkvm.healthRequest()
                    } label: {
                        Text("Authorize HealthKit")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    .frame(width: 320, height: 55)
                    .background(Color(.orange))
                    .cornerRadius(10)
                }
            }
            
        }
        .padding()
        .onAppear {
            hkvm.readWaterTakenToday()
        }
    }
}

#Preview {
    ContentView()
}
