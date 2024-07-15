//
//  FavoriteDestinationView.swift
//  GoodHusband
//
//  Created by vin chen on 13/07/24.
//

import SwiftUI

struct FavoriteDestinationView: View {
    var destination: String
    var location: String
    var humidity: Int
    var temperature: Int
    var weatherIcon: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack{
                Image(.sunnyIllustration)
                    .resizable()
                    .frame(alignment: .center)
                    .aspectRatio(contentMode: .fit)
                VStack(alignment:.leading){
                    HStack {
                        Image(systemName: "pin.fill")
                            .foregroundColor(.black)
                        Text("FAVOURITE DESTINATION")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                        
                        Spacer()
                        Button(action: {
                            // Unpin action
                        }) {
                            Text("Unpin")
                                .font(.caption)
                                .foregroundColor(.blue)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                        }
                        .background(.tertiary)
                        .cornerRadius(.greatestFiniteMagnitude)
                    }
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.secondary)
                    Text(destination)
                        .font(.title)
                        .bold()
                    Text(location)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    HStack {
                        Image(systemName: "drop.fill")
                            .foregroundColor(.black)
                        Text("\(humidity)%")
                            .font(.subheadline)
                        Spacer()
                        Image(systemName: "thermometer")
                            .foregroundColor(.black)
                        Text("\(temperature)°")
                            .font(.subheadline)
                        Spacer()
                        Image(systemName: weatherIcon)
                            .foregroundColor(.black)
                    }
                    .frame(width:160)
                }
                .padding()
            }
        }
        
        .background(Color(UIColor.sunnyBlue))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

#Preview {
    MainView()
}

