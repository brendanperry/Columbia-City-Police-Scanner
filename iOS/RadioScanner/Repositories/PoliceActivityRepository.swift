//
//  PoliceActivityRepository.swift
//  RadioScanner
//
//  Created by Brendan Perry on 9/24/24.
//

import shared
import PDFKit

struct PoliceActivityRepository {
    let repository = CCPoliceActivityRepository()
    
    func getActivityLogFor(day: Int, month: Int, year: Int) async throws -> ActivityLog {
        return try await withCheckedThrowingContinuation { continuation in
            repository.getActivitiesPdfDataForDate(day: Int32(day), month: Int32(month), year: Int32(year)) { data, error in
                if let error {
                    continuation.resume(throwing: error)
                    return
                }
                
                if let data {
                    guard let pdf = PDFDocument(data: data.toData()) else {
                        continuation.resume(throwing: NSError(domain: "No PDF Data Found", code: 404))
                        return
                    }
                    
                    guard let pdfString = pdf.string else {
                        continuation.resume(throwing: NSError(domain: "No PDF String Found", code: 404))
                        return
                    }
                    
                    let log = repository.readPdfStringData(data: pdfString, day: Int32(day), month: Int32(month), year: Int32(year))
                    continuation.resume(returning: log)
                        
                } else {
                    continuation.resume(throwing: NSError(domain: "No Data Found", code: 404))
                }
            }
        }
    }
}
