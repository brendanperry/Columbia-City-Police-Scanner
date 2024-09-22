//
//  CCPoliceActivityLog.swift
//  RadioScanner
//
//  Created by Brendan Perry on 9/20/24.
//
import Swift
import SwiftSoup
import PDFKit

enum ActivityLocation {
    case ColumbiaCity
}

struct ActivityLog {
    let day: Date
    let location: ActivityLocation
    let reportedActivities: [ReportedActivity]
}

struct ReportedActivity {
    let timestamp: Date
    let nature: String
    let address: String?
}

struct CCPoliceActivityLog {
    let baseUrl = "https://columbiacitypolice.us"
    let timestampFormatter: DateFormatter
    
    init() {
        timestampFormatter = DateFormatter()
        timestampFormatter.dateFormat = "HH:mm:ss MM/dd/yy"
        timestampFormatter.timeZone = .init(identifier: "America/Indiana/Indianapolis")
    }
    
    func getLatestActivity() async throws -> ActivityLog? {
        guard let url = URL(string: "\(baseUrl)/documents/DAILY%20STATS/9.11.24.pdf") else { return nil }
        var request = URLRequest(url: url).addingCommonHeaders()
        request.cachePolicy = .returnCacheDataElseLoad
        
        let data = try await URLSession.shared.data(for: request)
        
        if let pdf = PDFDocument(data: data.0) {
            if let stringData = pdf.string {
                let lines = stringData.split(whereSeparator: \.isNewline)
                
                var reportedActivities = [ReportedActivity]()
                
                for (index, line) in lines.enumerated() {
                    if (index == 0) { continue }
                    let spaceSplit = line.split(maxSplits: 2, whereSeparator: \.isWhitespace)
                    let time = String(spaceSplit[0])
                    let date = String(spaceSplit[1])
                    
                    let theRest = String(spaceSplit[2])
                    
                    let result = try theRest.split(separator: Regex("( E | S | W | N | \\d)"), maxSplits: 1)
                    
                    let nature = String(result[0])
                    var location: String? = nil
                    if (result.count > 1) {
                        location = String(result[1])
                    }
                    
                    guard let timestamp = timestampFormatter.date(from: time + " " + date) else { return nil }
                    
                    let activity = ReportedActivity(timestamp: timestamp, nature: nature, address: location)
                    
                    reportedActivities.append(activity)
                }
                
                return ActivityLog(day: Date(), location: .ColumbiaCity, reportedActivities: reportedActivities)
            }
        } else {
            print("AW MAN")
        }
        
        return nil
    }
}
