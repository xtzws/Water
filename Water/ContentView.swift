//
//  ContentView.swift
//  Water
//
//  Created by Isaac Greene on 2024-01-01.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "humidity.fill")
                .symbolEffect(.variableColor.cumulative.dimInactiveLayers.nonReversing)
                .imageScale(.large)
                .foregroundStyle(.blue)
            Text("The simplest water tracking app is on its way!")
            Text("Come back in a few days or so.")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
