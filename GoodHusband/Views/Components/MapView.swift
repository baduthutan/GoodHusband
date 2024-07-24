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
    @State private var showSearchBar = false
    
    @ObservedObject var mapViewModel = MapViewModel.singleton
    @ObservedObject var weatherViewModel = WeatherViewModel.singleton
    
    var body: some View {
        ZStack {
            VStack {
                MapSearchOverlayView(showSearchBar: $showSearchBar)
                Spacer()
            }
            .sheet(isPresented: $showSearchBar, content: {
                LocationSearchView(searchText: $mapViewModel.searchText, showSearchBar: $showSearchBar)
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
    @Binding var showSearchBar: Bool
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
                .padding(.leading, 8)
            
            Button(action: {
                showSearchBar.toggle()
            }, label: {
                HStack(content: {
                    Text("Search for a location...")
                        .foregroundColor(.secondary)
                        .padding(.leading, 4)
                    Spacer()
                })
            })
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
