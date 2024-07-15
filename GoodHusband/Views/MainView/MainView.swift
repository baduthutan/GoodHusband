//
//  MainView.swift
//  GoodHusband
//
//  Created by vin chen on 13/07/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack(spacing: 16) {
            LocationHeaderView(location: "SERPONG, TANGERANG", weatherDescription: "It’s Sunny all day!")
            FavoriteDestinationView(destination: "Summarecon", location: "Bekasi", humidity: 52, temperature: 28, weatherIcon: "cloud.sun.fill")
            Spacer()
        }
        .padding(.top)
        .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    MainView()
}
