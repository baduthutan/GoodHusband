//
//  ContentView.swift
//  GoodHusband
//
//  Created by vin chen on 09/07/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var weatherViewModel = WeatherViewModel.singleton
    
    var body: some View {
        MainView()
            .onAppear {
                Task {
                    weatherViewModel.fetchIsRainingNow()
                }
            }
    }
}

#Preview {
    ContentView()
}
