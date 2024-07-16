//
//  WeatherDetailView.swift
//  GoodHusband
//
//  Created by Irvan Wijaya on 16/07/24.
//

import SwiftUI

struct WeatherDetailView: View {
    var imageName: String
    var value: String
    
    var body: some View {
        VStack {
            Image(systemName: imageName)
                .font(.system(size: 22))
                .foregroundColor(.black)
                .padding(.bottom, 1)
            
            Text(value)
                .font(.system(size: 16))
                .foregroundColor(.black)
        }
        .frame(width: 55, height: 80)
        .background(Color.white)
        .cornerRadius(50)
        .shadow(color: Color.gray.opacity(0.4), radius: 4, x: 0, y: 2)
    }
}

struct WeatherDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            WeatherDetailView(imageName: "cloud.rain.fill", value: "90%")
            WeatherDetailView(imageName: "sun.max", value: "UV 5")
            WeatherDetailView(imageName: "humidity", value: "52%")
        }
        .previewLayout(.sizeThatFits)
    }
}
