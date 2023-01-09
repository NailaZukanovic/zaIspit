//
//  Restoraunt.swift
//  Recepti
//
//  Created by Digital Atrium on 16.11.22..
//

import Foundation
import MapKit

struct RestorauntLocation: Codable, Identifiable {
    var id: String
    var name: String
    var image: String
    var latitude: Double
    var longitude: Double
    
    // Computed Property
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
