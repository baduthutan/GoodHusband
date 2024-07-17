//
//  FavoritesManager.swift
//  GoodHusband
//
//  Created by Agfi on 17/07/24.
//

import Foundation

class FavoritesManager: ObservableObject {
    static let shared = FavoritesManager()
    @Published var favorites: [FavoriteLocation] = [] {
        didSet {
            saveFavorites()
        }
    }

    private let favoritesKey = "favoriteLocations"

    private init() {
        loadFavorites()
    }

    func addFavorite(location: FavoriteLocation) {
        if !favorites.contains(where: { $0.id == location.id }) {
            favorites.append(location)
        }
    }

    func removeFavorite(location: FavoriteLocation) {
        favorites.removeAll { $0.id == location.id }
    }

    private func saveFavorites() {
        if let encoded = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(encoded, forKey: favoritesKey)
        }
    }

    private func loadFavorites() {
        if let savedData = UserDefaults.standard.data(forKey: favoritesKey),
           let decoded = try? JSONDecoder().decode([FavoriteLocation].self, from: savedData) {
            favorites = decoded
        }
    }
}

struct FavoriteLocation: Identifiable, Codable, Equatable {
    let id: UUID
    let name: String
    let address: String
    let latitude: Double
    let longitude: Double
    let weatherCondition: String
    let weatherConditionDesc: String
    let temperature: Double
    let rainChance: Int
    let uvIndex: Int
    let humidity: Int
}
