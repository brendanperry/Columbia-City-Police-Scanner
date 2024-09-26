//
//  ReportedActivity+Extensions.swift
//  RadioScanner
//
//  Created by Brendan Perry on 9/25/24.
//

import shared

extension ReportedActivity {
    func timeValue() -> Date {
        let dateComponents = dateTime.toNSDateComponents()
        return Calendar.current.date(from: dateComponents) ?? Date()
    }
    
    func displayTime() -> String {
        let timeValue = timeValue()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        
        return dateFormatter.string(from: timeValue)
    }
}
