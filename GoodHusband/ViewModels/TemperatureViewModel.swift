//
//  TemperatureViewModel.swift
//  GoodHusband
//
//  Created by Dixon Willow on 17/07/24.
//

import Foundation

class TemperatureViewModel: ObservableObject {
    @Published var weatherImageName: String
    @Published var temperature: Int
    
    init(weatherImageName: String, temperature: Int) {
        self.weatherImageName = weatherImageName
        self.temperature = temperature
    }
}
