//
//  Date+Extensions.swift
//  RadioScanner
//
//  Created by Brendan Perry on 9/25/24.
//

import Foundation

extension Date {
    func daysAgo(days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: -days, to: self) ?? Date()
    }
    
    func hoursAgo(hours: Int) -> Date {
        return Calendar.current.date(byAdding: .hour, value: -hours, to: self) ?? Date()
    }
    
//    func cutMinutes() -> Date {
//        return Calendar.current.start(for: self)
//    }
}
