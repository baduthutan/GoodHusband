//
//  MapView.swift
//  GoodHusband
//
//  Created by Agfi on 11/07/24.
//

import SwiftUI
import WeatherKit
import CoreLocation
import MapKit

struct MapView: View {
    @State var mapSelection: MKMapItem?
    @State var isMapSelected: Bool = false
    @State private var showSearchResults = false

    @ObservedObject var mapViewModel = MapViewModel.singleton
    @ObservedObject var weatherViewModel = WeatherViewModel.singleton

    var body: some View {
        ZStack {
            VStack(content: {
                MapSearchOverlayView(searchText: $mapViewModel.searchText)
                .onSubmit(of: .text) {
                    Task {
                        await mapViewModel.searchPlaces()
                        showSearchResults = true
                    }
                }
                .onChange(of: mapSelection, { oldValue, newValue in
                    mapViewModel.showDetails = newValue != nil
                })
                Spacer()
                if showSearchResults {
                    List(mapViewModel.results, id: \.self) { item in
                        Button(action: {
                            mapSelection = item
                            showSearchResults = false
                            isMapSelected = true
                        }) {
                            VStack(alignment: .leading) {
                                Text(item.placemark.name ?? "Unknown Place")
                                    .font(.headline)
                                Text(item.placemark.title ?? "No address available")
                                    .font(.caption)
                            }
                        }
                    }
                }
            })
            .sheet(isPresented: $isMapSelected, content: {
                
            })
        }
    }
}

extension MKMapRect {
    init(coordinates: [CLLocationCoordinate2D]) {
        self = coordinates.reduce(MKMapRect.null) { (mapRect, coordinate) -> MKMapRect in
            let point = MKMapPoint(coordinate)
            let rect = MKMapRect(x: point.x, y: point.y, width: 0, height: 0)
            return mapRect.union(rect)
        }
    }
}

struct MapAnnotationView: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 32, height: 32)
                .foregroundStyle(.blue.opacity(0.25))
            Circle()
                .frame(width: 20, height: 20)
                .foregroundStyle(.white)
            Circle()
                .frame(width: 12, height: 12)
                .foregroundStyle(.blue)
        }
    }
}

struct MapSearchOverlayView: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.secondary)
                        .padding(.leading, 8)

                    ZStack(alignment: .leading) {
                        if searchText.isEmpty {
                            Text("Search for a location...")
                                .foregroundColor(.secondary)
                                .padding(.leading, 4)
                        }
                        TextField("", text: $searchText)
                            .foregroundColor(.primary)
                            .padding(.horizontal,4)
                    }
                }
                .font(.subheadline)
                .padding(8)
                .background(Color("BgCard"))
                .cornerRadius(8)
                .padding()
                .shadow(color: .black.opacity(0.2), radius: 2)
    }
}

#Preview {
    ContentView()
}
