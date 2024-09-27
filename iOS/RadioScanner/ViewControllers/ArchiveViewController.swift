//
//  ArchiveViewController.swift
//  RadioScanner
//
//  Created by Brendan Perry on 9/26/24.
//

import UIKit
import shared

class ArchiveViewController: UIViewController {
    @IBOutlet weak var hourPicker: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    let repository = WhitleyCountyRadioRepository()
    
    override func viewDidLoad() {
        configureDatePicker()
        
        hourPicker.dataSource = self
        hourPicker.delegate = self
    }
    
    fileprivate func configureDatePicker() {
        datePicker.maximumDate = Date()
        datePicker.date = Date().hoursAgo(hours: 1)
        datePicker.contentHorizontalAlignment = .center
    }

    func selectNewDate(date: Date) {
//        datePicker.date = date.toNearestHour()
    }
    
    func loadData() async {
        let components = Calendar.current.dateComponents([.year, .day, .month, .hour], from: datePicker.date)
        
        if let day = components.day, let month = components.month, let year = components.year, let hour = components.hour {
            // TODO: handle error
            let recordings = try? await repository.getRecordingsFor(day: Int32(day), month: Int32(month), year: Int32(year), hour: Int32(hour))
            
            print(recordings)
        }
        
    }
    
    @IBAction func datePickerValueChanged(_ sender: Any) {
        Task {
            await loadData()
        }
    }
}
