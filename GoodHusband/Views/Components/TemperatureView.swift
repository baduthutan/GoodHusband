//
//  TemperatureView.swift
//  GoodHusband
//
//  Created by Irvan Wijaya on 16/07/24.
//

import SwiftUI

struct TemperatureView: View {
    var weatherImageName: String
    var temperature: String
    var location: String
    
    var body: some View {
        HStack {
            Image(systemName: weatherImageName)
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.black)
            
            VStack(alignment: .leading) {
                Text(temperature)
                    .font(.system(size: 40, weight: .bold))
            }
            Spacer()
        }
    }
}

struct TemperatureView_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureView(weatherImageName: "cloud.rain.fill", temperature: "20°", location: "Serpong, Tangerang")
            .previewLayout(.sizeThatFits)
    }
}
