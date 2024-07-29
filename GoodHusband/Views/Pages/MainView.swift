//
//  MainView.swift
//  GoodHusband
//
//  Created by vin chen on 13/07/24.
//

import SwiftUI

struct MainView: View {
    @ObservedObject private var favoritesManager = FavoritesManager.shared
    private let weatherViewModel = WeatherViewModel.singleton
    private let mapViewModel = MapViewModel.singleton
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack(spacing: 10) {
                    LocationHeaderView()
                    if !favoritesManager.favorites.isEmpty {
                        ForEach(favoritesManager.favorites) { favorite in
                            PinnedLocationView(favorite: favorite, location: favorite.name, isRainy: true, weatherModel: WeatherModel(date: Date(), conditionSymbolName: favorite.weatherCondition, temperature: Int(favorite.temperature), rainChance: favorite.rainChance, uvIndex: favorite.uvIndex, humidity: favorite.humidity))
                        }
                    }
                    OverallForecastView()
                        .padding(.vertical, 16)
                    Spacer()
                }
                VStack(content: {
                    MapView()
                        .padding(.top, 195)
                    Spacer()
                })
            }
        }
        .background(Color("BgPage"))
        .ignoresSafeArea()
    }
    
    private func removeFavorites(at offsets: IndexSet) {
        offsets.forEach { index in
            let favorite = favoritesManager.favorites[index]
            favoritesManager.removeFavorite(location: favorite)
        }
    }
}

#Preview {
    MainView()
}
