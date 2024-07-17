//
//  MainView.swift
//  GoodHusband
//
//  Created by vin chen on 13/07/24.
//

import SwiftUI

struct MainView: View {
    
    private let weatherViewModel = WeatherViewModel.singleton
    private let mapViewModel = MapViewModel.singleton
    
    var body: some View {
        ZStack{
            VStack(spacing: 10) {
                LocationHeaderView()
                PinnedLocationView(location: "Summarecon", isRainy: true)
                Spacer()
            }
            .padding(.top)
            .background(Color(UIColor.systemGroupedBackground))
            .ignoresSafeArea()
            MapView()
                .padding(.top, 140)
        }
       
    }
}

#Preview {
    MainView()
    .background(Color("BgPage"))
}
