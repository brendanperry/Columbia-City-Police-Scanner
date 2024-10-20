//
//  ArchiveViewController.swift
//  RadioScanner
//
//  Created by Brendan Perry on 9/26/24.
//

import UIKit
import MobileVLCKit
import shared

class ArchiveViewController: UIViewController {
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let repository = WhitleyCountyRadioRepository()
    let videoPlayer = VLCMediaPlayer()
    
    var recordings = [Recording]()
    
    override func viewDidLoad() {
        configureDatePicker()
    }
    
    fileprivate func configureDatePicker() {
        datePicker.maximumDate = Date()
        datePicker.date = Date().hoursAgo(hours: 1)
        datePicker.contentHorizontalAlignment = .center
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func loadData() async {
        let components = Calendar.current.dateComponents([.year, .day, .month, .hour], from: datePicker.date)
        
        if let day = components.day, let month = components.month, let year = components.year, let hour = components.hour {
            // TODO: handle error
            let recordings = try? await repository.getRecordingsFor(day: Int32(day), month: Int32(month), year: Int32(year), hour: Int32(hour))
            
            self.recordings = recordings?.toArray() ?? self.recordings
            collectionView.reloadData()
        }
        
    }
    
    @IBAction func datePickerValueChanged(_ sender: Any) {
        Task {
            await loadData()
        }
    }
}
