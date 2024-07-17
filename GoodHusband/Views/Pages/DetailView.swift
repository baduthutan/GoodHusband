//
//  DetailView.swift
//  GoodHusband
//
//  Created by Rizki Maulana on 16/07/24.
//

import SwiftUI

struct DetailView: View {
    let location: String
    let address: String
    let latitude: Double
    let longitude: Double
    let weatherModel: WeatherModel
    
    @ObservedObject private var favoritesManager = FavoritesManager.shared
    @ObservedObject var weatherViewModel = WeatherViewModel.singleton
    @State private var isPinned: Bool = false
    private var favoriteLocation: FavoriteLocation
    
    init(location: String, address: String, latitude: Double, longitude: Double, weatherModel: WeatherModel) {
        self.location = location
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.weatherModel = weatherModel
        self.favoriteLocation = FavoriteLocation(
            id: UUID(),
            name: location,
            address: address,
            latitude: latitude,
            longitude: longitude,
            weatherCondition: weatherModel.conditionSymbolName,
            weatherConditionDesc: "Temperature: \(weatherModel.temperature)°C, Rain Chance: \(weatherModel.rainChance)%, UV Index: \(weatherModel.uvIndex), Humidity: \(weatherModel.humidity)%",
            temperature: Double(weatherModel.temperature),
            rainChance: weatherModel.rainChance,
            uvIndex: weatherModel.uvIndex,
            humidity: weatherModel.humidity
        )
    }
    
    var body: some View {
        ScrollView {
            /// LOCATION INFO SECTION
            HStack {
                Image(systemName:"location")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .aspectRatio(
                        contentMode: .fit)
                Text(location)
                    .font(.title2)
                    .padding(.leading, 8)
                Spacer()
            }
            .padding(.bottom, 20)
            
            /// DAILY WEATHER SECTION
            DailyWeatherView().padding(.bottom, 22)
            
            /// WEATHER INFO SECTION
            Text(weatherModel.conditionSymbolName)
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 6)
            Text("weatherConditionDesc")
                .padding(.bottom, 22)
            
            /// WEATHER DETAIL SECTION
            DestinationCardView(temperature: weatherModel.temperature, rainChance: weatherModel.rainChance, uvIndex: weatherModel.uvIndex, humidity: weatherModel.humidity, isPinned: isPinned)
                .padding(.bottom, 22)
            
            /// RECOMMENDATION SECTION
            ForEach((1..<4)) { _ in
                RecommendationView(recommendationViewModel: RecommendationViewModel( recommendation: RecommendationModel( imageName: "WarmClothes", title: "Don’t forget your sunscreen!", description: "The UV Index is currently high. Use sunscreen and re-apply every 4 hours.")))
            }
            
            /// BUTTON SECTION
            Button(action: {
                // TODO add action
            }) {
                Text("Search Other Location")
                    .frame(minWidth: 0, maxWidth: 256)
            }
            .background(.blue)
            .foregroundColor(.white)
            .buttonStyle(.borderedProminent)
            .cornerRadius(8)
            .padding(.bottom, 16)
            Button(action: {
                if isPinned {
                    favoritesManager.removeFavorite(location: favoriteLocation)
                } else {
                    favoritesManager.addFavorite(location: favoriteLocation)
                }
                isPinned.toggle()
            }, label: {
                Text(isPinned ? "Remove from Homepage" : "Pin This Information to Homepage")
            })
        }
        .padding(.horizontal, 16)
        .background(Color("BgCard"))
        .onAppear {
            isPinned = favoritesManager.favorites.contains(where: { $0.latitude == latitude && $0.longitude == longitude })

        }
    }
}


//#Preview {
//    DetailView(
//        location: "Summarecon, Bekasi",
//        weatherCondition: "It’s Sunny all day!",
//        weatherConditionDesc: "It doesn’t seem like going to rain there today."
//    )
//    .background(Color("BgCard"))
//}
