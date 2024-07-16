//
//  FavoriteDestinationView.swift
//  GoodHusband
//
//  Created by vin chen on 13/07/24.
//

import SwiftUI

struct DestinationCardView: View {
    var destination: String
    var location: String
    var humidity: Int
    var temperature: Int
    var weatherIcon: String
    var isPinned: Bool

    var body: some View {
        ZStack{
            Image(.sunnyDestination)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
           
            VStack(alignment:.leading, spacing: 12){
                    HStack(alignment:.center){
                        Text("\(temperature)°")
                            .font(.system(size: 48))
                            .bold()
                    HStack {
          
                            WeatherDetailView(imageName: "cloud.rain.fill", value: "90%")
                            WeatherDetailView(imageName: "sun.max", value: "UV 5")
                            WeatherDetailView(imageName: "humidity", value: "52%")
                        
                    }
                    .frame(width:150)
                }
                if isPinned == true{
                    VStack() {
                        Text("Click to see 7-day forecast")
                            .font(.caption)
                            .padding(6.0)
                            
                    }
                    .frame(maxWidth: .infinity)
                    .background(.white.opacity(0.75))
                    .cornerRadius(8)
                }
                }
            .padding()
        }
        .background(Color(UIColor.sunnyBlue))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

#Preview {
    MainView()
}

