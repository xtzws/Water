//
//  ContentView.swift
//  Water
//
//  Created by Isaac Greene on 2024-01-01.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.scenePhase) var scenePhase
    @EnvironmentObject var hkvm: HealthKitViewModel
    @State private var dietaryWater: Double?
    @State private var alertShown = false
    @State private var userWaterAmountAdd: String = ""
    @State private var scale = 1.0
    
    var body: some View {
        VStack {
            if hkvm.isAuthorized {
                
                VStack {
                    VStack {
                        HStack {
                            Image(systemName: "drop.degreesign.fill")
                            Text("Water today")
                        }
                        .padding(.top)
                        if hkvm.userWaterAmount != "" {
                            Text("\(hkvm.userWaterAmount)")
                                .fontWeight(.bold)
                                .font(.system(size: 120))
                                .fontWidth(.compressed)
                        } else {
                            Text("0")
                                .fontWeight(.bold)
                                .font(.system(size: 120))
                                .fontWidth(.compressed)
                        }
                        Text("ounces")
                            .padding(.bottom)
                    }
                    .frame(width: 200, height: 200)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
                    
                    VStack {
                        Button {
                            alertShown = true
                        } label: {
                            Label("Add water", systemImage: "plus.circle.fill")
                            .frame(width: 200, height: 70)
                            .background(.blue)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
                        }
                        .alert("How many ounces did you drink?", isPresented: $alertShown) {
                            TextField("Ounces of water", text: $userWaterAmountAdd)
                                .keyboardType(.decimalPad)
                            Button ("Cancel", role: .cancel) {userWaterAmountAdd = ""}
                            Button ("Add") {
                                if userWaterAmountAdd != "" {
                                    hkvm.writeWater(amount: Double(userWaterAmountAdd)!) // trust me bro there's something here
                                    userWaterAmountAdd = ""
                                } else {

                                }
                                sleep(2)
                                hkvm.readWaterTakenToday()
                            }
                        }
                    }
                }
            } else {
                ScrollView {
                    VStack (alignment: .leading) {
                        Text("Welcome!")
                            .font(.title)
                            .padding(.bottom)
                        Text("What is this app?")
                            .font(.title2)
                            .padding(.bottom)
                        Text("This is my attempt at the simplest water tracker possible. It does exactly two things: read water and record water.")
                            .padding(.bottom)
                        Text("I also wanted it to be privacy-centric. There are no ads, no in-app purchases, no subscriptions, no trackers, no logins, no settings, no nothin'.")
                            .padding(.bottom)
                        Text("Why connect to Apple Health?")
                            .font(.title2)
                            .padding(.bottom)
                        Text("There are a couple reasons for this. First, I'm lazy. I didn't want to learn or deal with storing data. Apple Health has already done it.")
                            .padding(.bottom)
                        Text("Second, it means that no data you save is stored in the app. Apple automatically encrypts all health data on your device, so there are no chances of someone stealing it. Regular app data is not stored the same way, so it is less secure.")
                            .padding(.bottom)
                        Text("Third, I'm not a thief. There's absolutely no reason why only I should get your water usage.")
                            .padding(.bottom)
                        Text("Done reading?")
                            .font(.title2)
                            .padding(.bottom)
                        Text("Before you click the button, know that you can deny either permission. If you allow read but not write, I can show you how much water you have consumed today, but not save any. If you allow write but not read, I can log your water, but only read what you logged with my app.")
                            .padding(.bottom)
                        Text("If you want this app to do absolutely nothing, deny read and write access!")
                            .padding(.bottom)
                        Text("Made with spite in the USA 🇺🇸🦅🇺🇸🦅🇺🇸🦅🇺🇸")
                            .padding(.bottom)
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
        .onChange(of: scenePhase) {
                        if scenePhase == .inactive {
                            hkvm.readWaterTakenToday()
                        } else if scenePhase == .active {
                            hkvm.readWaterTakenToday()
                        } else if scenePhase == .background {
                            hkvm.readWaterTakenToday()
                        }
                    }
    }
}

#Preview {
    ContentView().environmentObject(HealthKitViewModel())
}
