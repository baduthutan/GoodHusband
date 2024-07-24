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
    
    @State var mapSelection: MKMapItem?
    @State var isMapSelected: Bool = false
    @State var showSearchResults = false
    
    @ObservedObject var mapViewModel = MapViewModel.singleton
    @ObservedObject var weatherViewModel = WeatherViewModel.singleton
    var body: some View {
        VStack(content: {
            HStack(content: {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                    .padding(.leading, 8)
                ZStack(alignment: .leading, content: {
                    if searchText.isEmpty {
                        HStack(content: {
                            Text("Search for a location...")
                                .foregroundColor(.secondary)
                                .padding(.leading, 4)
                            Spacer()
                        })
                    }
                    TextField("", text: $searchText)
                        .foregroundColor(.primary)
                        .padding(.horizontal,4)
                })
            })
            .font(.subheadline)
            .padding(8)
            .background(Color("BgCard"))
            .cornerRadius(8)
            .padding()
            .shadow(color: .black.opacity(0.2), radius: 2)
            
            if showSearchResults {
                List(mapViewModel.results, id: \.self) { item in
                    NavigationLink(destination: {
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
                        }
                    }, label: {
                        Button(action: {
                            mapSelection = item
                            showSearchResults = false
                            isMapSelected = true
                            showSearchBar.toggle()
                            weatherViewModel.fetchWeather()
                        }) {
                            VStack(alignment: .leading) {
                                Text(item.placemark.name ?? "Unknown Place")
                                    .font(.headline)
                                Text(item.placemark.title ?? "No address available")
                                    .font(.caption)
                            }
                        }
                    })
                }
            }
            
            Spacer()
        })
        .onSubmit(of: .text) {
            Task {
                await mapViewModel.searchPlaces()
                showSearchResults = true
            }
        }
        .onChange(of: mapSelection, { oldValue, newValue in
            mapViewModel.showDetails = newValue != nil
        })
    }
}

#Preview {
    ContentView()
}
