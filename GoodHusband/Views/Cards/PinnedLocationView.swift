//
//  PinnedLocationView.swift
//  GoodHusband
//
//  Created by vin chen on 16/07/24.
//

import SwiftUI

struct PinnedLocationView: View {
    var location: String
    var isRainy: Bool
    var body: some View {
        VStack{
            VStack(spacing: 12.0){
                HStack{
                    Image(systemName: "pin.fill")
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                    Text("overall forecast in \(location)")
                        .font(.system(size: 11))
                        .textCase(.uppercase)
                    Spacer()
                    VStack() {
                        Text("Unpin")
                            .font(.caption)
                            .padding(6.0)
                            
                    }
                    .frame(width: 70)
                    .background(.tertiary)
                    .foregroundColor(.red)
                    .cornerRadius(8)
                }
                DestinationCardView(temperature: 28, rainChance: 50, uvIndex: 5, humidity: 52, isPinned: true)
                if isRainy == true{
                    HStack() {
                        Image(systemName: "cloud.fill")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                            .padding(.leading)
                        Text("Showers expected at 6PM.")
                            .font(.caption)
                            .padding(.vertical, 6.0)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(.blue)
                    .cornerRadius(8)
                }
                RecommendationView(imageName: "WarmClothes", title: "Don’t forget your sunscreen!", description: "The UV Index is currently high. Use sunscreen and re-apply every 4 hours.")
                RecommendationView(imageName: "WarmClothes", title: "Don’t forget your sunscreen!", description: "The UV Index is currently high. Use sunscreen and re-apply every 4 hours.")
                RecommendationView(imageName: "WarmClothes", title: "Don’t forget your sunscreen!", description: "The UV Index is currently high. Use sunscreen and re-apply every 4 hours.")
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(10)
        .padding()
        .shadow(color: .black.opacity(0.2), radius: 2)
    }
}

#Preview {
    PinnedLocationView(location: "Summarecon", isRainy: true)
}
