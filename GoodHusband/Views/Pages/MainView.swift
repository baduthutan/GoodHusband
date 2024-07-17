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
        NavigationView(content: {
            ZStack{
                VStack(spacing: 10) {
                    LocationHeaderView()
                    if !favoritesManager.favorites.isEmpty {
                        Text("Favorite Locations")
                            .font(.headline)
                            .padding(.top)
                        
                        ScrollView(content: {
                            ForEach(favoritesManager.favorites) { favorite in
                                    NavigationLink(destination: {
                                        DetailView(
                                            location: favorite.name,
                                            address: favorite.address,
                                            latitude: favorite.latitude,
                                            longitude: favorite.longitude,
                                            weatherModel: WeatherModel(
                                                date: Date(),
                                                conditionSymbolName: favorite.weatherCondition,
                                                temperature: Int(favorite.temperature),
                                                rainChance: favorite.rainChance,
                                                uvIndex: favorite.uvIndex,
                                                humidity: favorite.humidity
                                            )
                                        )
                                    }, label: {
                                        PinnedLocationView(location: favorite.name, isRainy: true, weatherModel: WeatherModel(date: Date(), conditionSymbolName: favorite.weatherCondition, temperature: Int(favorite.temperature), rainChance: favorite.rainChance, uvIndex: favorite.uvIndex, humidity: favorite.humidity))
                                    })
                            }
                        })
                        .background(.white)
                    }
                    Spacer()
                }
                .padding(.top)
                .background(Color(UIColor.systemGroupedBackground))
                .ignoresSafeArea()
                MapView()
                    .padding(.top, 140)
            }
        })
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
