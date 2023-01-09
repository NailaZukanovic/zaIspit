//
//  MapView.swift
//  Recepti
//
//  Created by Digital Atrium on 15.11.22..
//

import SwiftUI
import MapKit

struct MapView: View {
    
    // Novi Pazar
    // 43.14113726620205, 20.518341093117137
    private static let noviPazarLatLon = CLLocationCoordinate2D(latitude: 43.14113726620205, longitude: 20.518341093117137)
    
    @StateObject private var viewModel = MapViewModel()

    @State private var region: MKCoordinateRegion = {
            
            var mapCoordinates = noviPazarLatLon
            var mapZoomLevel = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            var mapRegion = MKCoordinateRegion(center: mapCoordinates, span: mapZoomLevel)
            
            return mapRegion
        }()
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: viewModel.restoraunts, annotationContent: { item in
                MapAnnotation(coordinate: item.location) {
                    MapAnnotationView(location: item)
                }
            })
        .navigationTitle("Restoraunts")
    }
}

struct MapView_Previews: PreviewProvider {
    
    static var locs: [RestorauntLocation] = {
        var locations: [RestorauntLocation] = []
        locations.append(RestorauntLocation(id: "", name: "Broj 1", image: "https://lh5.googleusercontent.com/p/AF1QipPN-59ZwSrGbEPk6Ut5GIXhHU6gFts6OMdG6gf1=w408-h269-k-no", latitude: 43.14329415762662, longitude: 20.51538347094671))
        return locations
    }()
    
    static var previews: some View {
        MapView()
    }
}
