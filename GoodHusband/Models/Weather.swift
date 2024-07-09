//
//  Weather.swift
//  GoodHusband
//
//  Created by vin chen on 09/07/24.
//

import Foundation

struct Weather: Identifiable {
    let id = UUID()
    let temperature: Double
    let condition: String
}

