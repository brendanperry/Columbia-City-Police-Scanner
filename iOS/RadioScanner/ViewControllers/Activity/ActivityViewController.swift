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
    
    let activityRepository = PoliceActivityRepository()
    let geocodeManager = GeocodeManager()
    var reportedActivities = [ReportedActivity]()
    var filteredReportedActivities = [ReportedActivity]()
    var selectedActivity: ReportedActivity?
    let radioRepository = WhitleyCountyRadioRepository()
    
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
            guard let log = try await activityRepository.getActivityLogFor(day: day, month: month, year: year) else { return }
            
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
        
        clearPlacemarksFromMap()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedActivity else { return }
        if let audioPlayerViewController = segue.destination as? AudioPlayerViewController {
            
            Task {
                let components = selectedActivity.dateTime.toNSDateComponents()
                
                if let day = components.day, let month = components.month, let year = components.year, let hour = components.hour {
                    // TODO: handle error
                    guard let recordings = try? await radioRepository.getRecordingsFor(day: Int32(day), month: Int32(month), year: Int32(year), hour: Int32(hour)) else { return }
                    
                    let recordingList = recordings.toArray()
                    
                    for recording in recordingList {
                        if recording.startTime.minute <= selectedActivity.dateTime.minute && recording.endTime.minute >= selectedActivity.dateTime.minute {
                            audioPlayerViewController.loadViewIfNeeded()
                            audioPlayerViewController.setRecording(recording: recording, for: selectedActivity)
                            return
                        }
                    }
                }
            }
        }
    }
}
