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

    @ObservedObject var mapViewModel: MapViewModel
    @ObservedObject var weatherViewModel: WeatherViewModel

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
                WeatherView()
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
        TextField("Search for a location...", text: $searchText)
            .font(.subheadline)
            .padding(12)
            .background(Color.white)
            .padding()
            .shadow(radius: 10)
    }
}

#Preview {
    ContentView()
}
