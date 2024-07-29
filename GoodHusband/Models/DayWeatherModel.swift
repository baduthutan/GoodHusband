//
//  DayWeatherModel.swift
//  GoodHusband
//
//  Created by Dixon Willow on 17/07/24.
//

import Foundation

struct DayWeatherModel: Identifiable {
    var id = UUID()
    var date: Date
    var day: String
    var symbol: String
    var temperature: Int
    var isActive: Bool
}
