//
//  SwiftUIView.swift
//  GoodHusband
//
//  Created by vin chen on 17/07/24.
//

import SwiftUI

struct OverallForecastView: View {
    var location: String
    var body: some View {
        VStack{
            VStack(spacing: 12.0){
                HStack{
                    Image(systemName: "location")
                        .font(.system(size: 14))
                    Text("overall forecast in \(location)")
                        .font(.system(size: 11))
                        .textCase(.uppercase)
                    Spacer()
                }
                DailyWeatherView()
                HStack{
                    TemperatureView(weatherImageName: "cloud.rain.fill", temperature: "20°", location: "Serpong, Tangerang")
                        .previewLayout(.sizeThatFits)
                    Spacer()
                    HStack {
                        WeatherDetailView(weatherDetailViewModel: WeatherDetailViewModel(imageName: .rainChance), background: Color("BGCardSecondary"), foreground:Color("ForegroundColor"))
                        WeatherDetailView(weatherDetailViewModel: WeatherDetailViewModel(imageName: .uvIndex), background: Color("BGCardSecondary"), foreground:Color("ForegroundColor"))
                        WeatherDetailView(weatherDetailViewModel: WeatherDetailViewModel(imageName: .humidity), background: Color("BGCardSecondary"), foreground:Color("ForegroundColor"))
                    }
                }
                RecommendationView(imageName: "WarmClothes", title: "Don’t forget your sunscreen!", description: "The UV Index is currently high. Use sunscreen and re-apply every 4 hours.")
                RecommendationView(imageName: "WarmClothes", title: "Don’t forget your sunscreen!", description: "The UV Index is currently high. Use sunscreen and re-apply every 4 hours.")
                RecommendationView(imageName: "WarmClothes", title: "Don’t forget your sunscreen!", description: "The UV Index is currently high. Use sunscreen and re-apply every 4 hours.")
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .background(Color("BgCard"))
        .cornerRadius(10)
        .padding(.horizontal)
        .shadow(color: .black.opacity(0.2), radius: 2)
    }
}
#Preview {
    OverallForecastView(location: "BSD, Tangerang")
}
