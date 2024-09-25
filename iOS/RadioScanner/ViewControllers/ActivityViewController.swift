//
//  ActivityViewController.swift
//  RadioScanner
//
//  Created by Brendan Perry on 9/22/24.
//

import UIKit
import shared
import MapKit

class ActivityViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UISearchBarDelegate {
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var activityCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    
    let repository = PoliceActivityRepository()
    var reportedActivities = [ReportedActivity]()
    var filteredReportedActivities = [ReportedActivity]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityCollectionView.dataSource = self
        activityCollectionView.delegate = self
        searchBar.delegate = self
        datePicker.contentHorizontalAlignment = .center
        datePicker.date = Calendar.current.date(byAdding: .day, value: -2, to: Date())!
        datePicker.maximumDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        datePicker.minimumDate = Calendar.current.date(byAdding: .day, value: -31, to: Date())!
        dateChanged(datePicker)
        
        mapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.15636, longitude: -85.48981), span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredReportedActivities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as? ActivityCollectionViewCell {
            
            let activity = filteredReportedActivities[indexPath.row]
            
            cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor.systemBackground : UIColor(named: "CollectionSecondary")
            
            cell.configure(with: activity)
            return cell
        }
        
        return UICollectionViewCell(frame: .zero)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = view.frame.size.width
        // in case you you want the cell to be 40% of your controllers view
        return CGSize(width: width , height: 100)
    }
    
    func updateData(day: Int, month: Int, year: Int) async {
        do {
            let log = try await repository.getActivityLogFor(day: day, month: month, year: year)
            
            searchBar.text = ""
            reportedActivities = log.reportedActivity
            filteredReportedActivities = reportedActivities
            
            for activity in filteredReportedActivities {
                let geocoder = CLGeocoder()
                if let address = activity.address {
                    geocoder.geocodeAddressString(address + " Columbia City, IN 46725") {
                        (placemarks, error) in
                        if let coord = placemarks?.first?.location?.coordinate {
                            let placemark = MKPointAnnotation()
                            placemark.coordinate = coord
                            placemark.title = activity.nature
                            placemark.subtitle = activity.address
                            self.mapView.addAnnotation(placemark)
                        }
                    }
                }
            }
            
            activityCollectionView.reloadData()
        } catch {
            print(error.localizedDescription)
            // TODO: Show the error!!
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count < 2 {
            filteredReportedActivities = reportedActivities
        } else {
            let filterText = searchText.lowercased()
            filteredReportedActivities = reportedActivities.filter {
                let textToSearch = $0.address ?? "" + $0.nature
                return textToSearch.lowercased().contains(filterText)
            }
        }
        
        activityCollectionView.reloadData()
    }
    
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .month, .year], from: sender.date)
        
        if let day = components.day, let month = components.month, let year = components.year {
            Task {
                await updateData(day: day, month: month, year: year % 100)
            }
        }
    }
}
