//
//  TemperatureView.swift
//  GoodHusband
//
//  Created by Irvan Wijaya on 16/07/24.
//

import SwiftUI

struct TemperatureView: View {
    
    @ObservedObject var temperatureViewModel: TemperatureViewModel
    
    var body: some View {
        HStack {
            Image(systemName: temperatureViewModel.weatherImageName)
                .resizable()
                .frame(width: 40, height: 40)
            Text("\(temperatureViewModel.temperature)°")
                .font(.system(size: 40, weight: .bold))
        }
    }
}

struct TemperatureView_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureView(temperatureViewModel: TemperatureViewModel(weatherImageName: "cloud.rain.fill", temperature: 20))
            .previewLayout(.sizeThatFits)
    }
}
