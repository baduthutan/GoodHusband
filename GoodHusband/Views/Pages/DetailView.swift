//
//  DetailView.swift
//  GoodHusband
//
//  Created by Rizki Maulana on 16/07/24.
//

import SwiftUI

struct DetailView: View {
    let location: String
    let weatherCondition: String
    let weatherConditionDesc: String
    
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
            Text(weatherCondition)
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 6)
            Text(weatherConditionDesc)
                .padding(.bottom, 22)
            
            /// WEATHER DETAIL SECTION
            DestinationCardView(temperature: 28, rainChance: 50, uvIndex: 5, humidity: 52, isPinned: false)

                .padding(.bottom, 22)
            
            /// RECOMMENDATION SECTION
            ForEach((1..<4)) { _ in
            RecommendationView(imageName: "WarmClothes", title: "Don’t forget your sunscreen!", description: "The UV Index is currently high. Use sunscreen and re-apply every 4 hours.")
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
            .padding(.vertical, 16)
            Button("Pin This Information to Homepage") {
                // TODO add action
            }
        }.padding(.horizontal, 16)
            .background(Color("BgCard"))
    }
}

#Preview {
    DetailView(
        location: "Summarecon, Bekasi",
        weatherCondition: "It’s Sunny all day!",
        weatherConditionDesc: "It doesn’t seem like going to rain there today."
    )
    .background(Color("BgCard"))
}
