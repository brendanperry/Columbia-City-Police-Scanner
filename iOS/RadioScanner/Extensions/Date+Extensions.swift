//
//  Date+Extensions.swift
//  RadioScanner
//
//  Created by Brendan Perry on 9/25/24.
//

import Foundation

extension Date {
    func yesterday() -> Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self) ?? Date()
    }
    
    func twoDaysAgo() -> Date {
        return Calendar.current.date(byAdding: .day, value: -2, to: self) ?? Date()
    }
    
    func lastMonth() -> Date {
        return Calendar.current.date(byAdding: .day, value: -31, to: self) ?? Date()
    }
}
