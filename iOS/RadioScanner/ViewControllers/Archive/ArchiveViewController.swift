//
//  ArchiveViewController.swift
//  RadioScanner
//
//  Created by Brendan Perry on 9/26/24.
//

import UIKit
import shared

class ArchiveViewController: UIViewController {
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var hourMenu: UIMenu!
    
    let repository = WhitleyCountyRadioRepository()
    
    override func viewDidLoad() {
        configureDatePicker()
    }
    
    fileprivate func configureDatePicker() {
        datePicker.maximumDate = Date()
        datePicker.date = Date().hoursAgo(hours: 1)
        datePicker.contentHorizontalAlignment = .center
    }
    
    func loadData() async {
        let components = Calendar.current.dateComponents([.year, .day, .month, .hour], from: datePicker.date)
        
        if let day = components.day, let month = components.month, let year = components.year, let hour = components.hour {
            // TODO: handle error
            let recordings = try? await repository.getRecordingsFor(day: 16, month: 10, year: 2024, hour: 8)
            
            print(recordings?.toArray())
        }
        
    }
    
    @IBAction func datePickerValueChanged(_ sender: Any) {
        Task {
            await loadData()
        }
    }
}
