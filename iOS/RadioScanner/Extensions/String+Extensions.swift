//
//  String+Extensions.swift
//  RadioScanner
//
//  Created by Brendan Perry on 9/25/24.
//

import CoreLocation

extension String {
    func addressToCoordinates() async -> CLLocationCoordinate2D? {
        let geocoder = CLGeocoder()
        
        let placemarks = try? await geocoder.geocodeAddressString(self)
        
        return placemarks?.first?.location?.coordinate
    }
}
