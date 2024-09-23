//
//  ActivityLog.swift
//  RadioScanner
//
//  Created by Brendan Perry on 9/22/24.
//

import Foundation

struct ActivityLog {
    let day: Date
    let location: ActivityLocation
    let reportedActivities: [ReportedActivity]
}
