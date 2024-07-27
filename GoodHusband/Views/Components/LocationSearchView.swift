//
//  LocationSearchView.swift
//  GoodHusband
//
//  Created by Agfi on 24/07/24.
//

import SwiftUI
import MapKit

struct LocationSearchView: View {
    @Binding var searchText: String
    @Binding var showSearchBar: Bool
    
    @State private var mapSelection: MKMapItem?
    @State private var isMapSelected: Bool = false
    @State private var showSearchResults = false
    
    @ObservedObject var mapViewModel = MapViewModel.singleton
    @ObservedObject var weatherViewModel = WeatherViewModel.singleton
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                    .padding(.leading, 8)
                ZStack(alignment: .leading) {
                    if searchText.isEmpty {
                        HStack {
                            Text("Search for a location...")
                                .foregroundColor(.secondary)
                                .padding(.leading, 4)
                            Spacer()
                        }
                    }
                    TextField("", text: $searchText)
                        .foregroundColor(.primary)
                        .padding(.horizontal, 4)
                        .onSubmit {
                            Task {
                                await mapViewModel.searchPlaces()
                                showSearchResults = true
                            }
                        }
                }
            }
            .font(.subheadline)
            .padding(8)
            .background(Color("BgCard"))
            .cornerRadius(8)
            .padding()
            .shadow(color: .black.opacity(0.2), radius: 2)
            
            if showSearchResults {
                List(mapViewModel.results, id: \.self) { item in
                    Button(action: {
                        mapSelection = item
                        showSearchResults = false
                        showSearchBar = false
                        isMapSelected = true
                        weatherViewModel.fetchWeather()
                    }) {
                        VStack(alignment: .leading) {
                            Text(item.placemark.name ?? "Unknown Place")
                                .font(.headline)
                            Text(item.placemark.title ?? "No address available")
                                .font(.caption)
                        }
                        .foregroundColor(.blue)
                    }
                }
            } else {
                Text("Please type places to search!")
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .background(
            NavigationLink(destination: DetailViewContainer(mapSelection: mapSelection), isActive: $isMapSelected) {
                EmptyView()
            }
        )
    }
}


struct DetailViewContainer: View {
    var mapSelection: MKMapItem?
    @ObservedObject var weatherViewModel = WeatherViewModel.singleton
    
    var body: some View {
        if let mapSelection = mapSelection,
           let location = mapSelection.placemark.name,
           let administrativeArea = mapSelection.placemark.administrativeArea,
           let latitude = mapSelection.placemark.location?.coordinate.latitude,
           let longitude = mapSelection.placemark.location?.coordinate.longitude,
           let weatherModel = weatherViewModel.weatherModel {
            
            DetailView(
                location: location,
                address: "\(location), \(administrativeArea)",
                latitude: latitude,
                longitude: longitude,
                weatherModel: weatherModel
            )
        } else {
            EmptyView()
        }
    }
}

#Preview {
    ContentView()
}

//DetailView(
//    location: mapSelection?.placemark.name ?? "Location Not Found",
//    address: "\(mapSelection?.placemark.name ?? ""), \(mapSelection?.placemark.administrativeArea ?? "")",
//    latitude: mapSelection?.placemark.location?.coordinate.latitude ?? 0,
//    longitude: mapSelection?.placemark.location?.coordinate.longitude ?? 0,
//    weatherModel: weatherViewModel.weatherModel!
//)
