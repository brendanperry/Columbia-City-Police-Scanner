//
//  ActivityViewController+Map.swift
//  RadioScanner
//
//  Created by Brendan Perry on 9/25/24.
//

import shared
import MapKit

extension ActivityViewController: MKMapViewDelegate {
    
    internal func setMapStartingPoint() {
        mapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.15636, longitude: -85.48981), span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
    }
    
    internal func clearPlacemarksFromMap() {
        mapView.removeAnnotations(mapView.annotations)
    }
    
    internal func addPlacemarksToMap(activities: [ReportedActivity]) async {
        for activity in activities {
            guard let streetAddress = activity.address else { continue }
            let fullAddress = streetAddress + " Columbia City, IN 46725"
            if let coordinates = await geocodeManager.getCoordinatesFromAddress(address: fullAddress) {
                addPlacemark(coordinate: coordinates, activity: activity)
            }
        }
    }
    
    private func addPlacemark(coordinate: CLLocationCoordinate2D, activity: ReportedActivity) {
        let placemark = MKPointAnnotation()
        placemark.coordinate = coordinate
        placemark.title = activity.nature
        placemark.subtitle = activity.address
        self.mapView.addAnnotation(placemark)
    }
    
    func mapView(_ mapView: MKMapView, didSelect: MKAnnotationView) {
        if let index = filteredReportedActivities.firstIndex(where: {
            $0.nature == didSelect.annotation?.title &&
            $0.address == didSelect.annotation?.subtitle
        }) {
            let indexPath = IndexPath(row: Int(index), section: 0)
            activityCollectionView.scrollToItem(at: indexPath, at: .top, animated: true)
        }
    }
}
