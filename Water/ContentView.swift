//
//  ContentView.swift
//  Water
//
//  Created by Isaac Greene on 2024-01-01.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var hkvm: HealthKitViewModel
    @State private var dietaryWater: Double?
    @State private var alertShown = false
    @State private var userWaterAmountAdd: String = ""
    
    var body: some View {
        VStack {
            if hkvm.isAuthorized {
                VStack {
                    HStack {
                        Image(systemName: "drop.degreesign.fill")
                        Text("Water today")
                    }
                    if hkvm.userWaterAmount != "" {
                        Text("\(hkvm.userWaterAmount) ounces")
                            .fontWeight(.bold)
                    } else {
                        Text("0 ounces")
                            .fontWeight(.bold)
                    }
                    Button ("Add Water") {
                        alertShown = true
                    }
                    .buttonStyle(.bordered)
                    .alert("Please enter how many ounces of water you drank", isPresented: $alertShown) {
                        TextField("water in ounces", text: $userWaterAmountAdd)
                            .keyboardType(.numberPad)
                        Button ("Cancel", role: .cancel) {}
                        Button ("Add") {
                            if userWaterAmountAdd != "" {
                                hkvm.writeWater(amount: Double(userWaterAmountAdd)!)
                            } else {
                                
                            }
                        }
                    }
                }
            } else {
                ScrollView {
                    VStack (alignment: .leading) {
                        Text("Welcome!")
                            .font(.largeTitle)
                        Text("What is this app?")
                            .font(.title)
                        Text("This is my attempt at the simplest water tracker possible. It does exactly two things: read water and record water.")
                        Text("I also wanted it to be privacy-centric. There are no ads, no in-app purchases, no subscriptions, no trackers, no logins, no settings, etc.")
                        Text("For extra security, this app stores no data whatsoever. With your explicit permission, this app will connect to the Apple Health app and do neither, one, or both of two things. Read water you've already logged today with another app, and save water you track with this app.")
                        Text("Why connect to Apple Health?")
                            .font(.title)
                        Text("There are a few reasons for this. First, it means that no data you save is stored in the app. Apple automatically encrypts all health data on your device, so there are no chances of someone stealing it. Regular app data is not stored the same way, so it is more insecure.")
                        Text("Second, it means that water you save here can be accessed by other nutrition apps. You deserve to have access to your data. If it was only here, you wouldn't have that access.")
                        Text("Third, I don't feel like working with app storage when I can pass the job off to something else (that can do it faster, easier, more securely) and it would be redundant. If I wanted your water data to be interoperable, I would have to save it to Health anyway.")
                        Text("Important Recap")
                            .font(.title2)
                        Text("Before you access the permissions, I wanted to recap what happens to your health data. Your health data is never tracked, stored, sold, transmitted, or shared with anyone. It is hard-coded in that we only access water from midnight today, never before. Whatever you drank yesterday? Invisible to us. There are no ads, no monetization on my part, it never has and never will connect to the internet. It will never ask for permissions beyond reading or writing one single piece of data.")
                        Text("Done reading all this? Before you click the button, know that you can deny either permission. If you allow read but not write, we can show you how much water you have consumed today, but not save any. If you allow write but not read, we can log your water, but not show you how much. The bar will always show \"0 ounces\". You can, of course, always add and see data in the Apple Health app directly. This app should work mostly fine if you deny either permission.")
                        Button {
                            hkvm.healthRequest()
                        } label: {
                            Text("Connect to Apple Health")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        .frame(width: 320, height: 55)
                        .background(Color(.red))
                        .cornerRadius(10)
                    }
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
