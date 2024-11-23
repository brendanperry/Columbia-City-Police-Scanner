//
//  ActivityViewController.swift
//  RadioScanner
//
//  Created by Brendan Perry on 9/22/24.
//

import UIKit
import shared
import MapKit

class ActivityViewController: UIViewController {
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var activityCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var noActivitiesFoundText: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    let repository = PoliceActivityRepository()
    let geocodeManager = GeocodeManager()
    var reportedActivities = [ReportedActivity]()
    var filteredReportedActivities = [ReportedActivity]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityCollectionView.dataSource = self
        activityCollectionView.delegate = self
        searchBar.delegate = self
        mapView.delegate = self
        
        configureDatePicker()
        setMapStartingPoint()
    }
    
    func updateData(day: Int, month: Int, year: Int) async {
        do {
            // TODO: Handle null? throw error instead?
            guard let log = try await repository.getActivityLogFor(day: day, month: month, year: year) else { return }
            
            searchBar.text = ""
            reportedActivities = log.reportedActivity
            filteredReportedActivities = reportedActivities
        } catch {
            print(error.localizedDescription)
            reportedActivities.removeAll()
            filteredReportedActivities.removeAll()
            // TODO: Show the error !! ??
        }
        noActivitiesFoundText.isHidden = !reportedActivities.isEmpty
        
        activityCollectionView.reloadData()

        await addPlacemarksToMap(activities: filteredReportedActivities)
    }

    private func configureDatePicker() {
        let today = Date()
        
        datePicker.contentHorizontalAlignment = .center
        datePicker.date = today.daysAgo(days: 2)
        datePicker.maximumDate = today.daysAgo(days: 1)
        datePicker.minimumDate = today.daysAgo(days: 31)
        dateChanged(datePicker)
    }
    
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        let components = Calendar.current.dateComponents([.day, .month, .year], from: sender.date)
        
        if let day = components.day, let month = components.month, let year = components.year {
            Task {
                await updateData(day: day, month: month, year: year % 100)
            }
        }
    }
}
