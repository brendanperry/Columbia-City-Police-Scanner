//
//  GeocodeManager.swift
//  RadioScanner
//
//  Created by Brendan Perry on 9/25/24.
//

import CoreLocation

class GeocodeManager {
    var geocodeCache = [String: CLLocationCoordinate2D?]()
    let geocoder = CLGeocoder()
    
    func getCoordinatesFromAddress(address: String) async -> CLLocationCoordinate2D? {
        if let cached = geocodeCache[address] {
            return cached
        }
        
        let placemarks = try? await geocoder.geocodeAddressString(address)
        let coordinate = placemarks?.first?.location?.coordinate
        
        if let coordinate {
            geocodeCache[address] = coordinate
        }
        
        return coordinate
    }
}
