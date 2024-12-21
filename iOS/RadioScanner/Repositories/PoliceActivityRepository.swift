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
    
    func getActivityLogFor(day: Int, month: Int, year: Int) async throws -> ActivityLog? {
        let result = try await repository.getActivitiesPdfDataForDate(day: Int32(day), month: Int32(month), year: Int32(year))
        
        if let result {
            guard let pdf = PDFDocument(data: result.toData()) else {
                throw NSError(domain: "No PDF Data Found", code: 404)
            }
            
            guard let pdfString = pdf.string else {
                throw NSError(domain: "No PDF String Found", code: 404)
            }
            
            return repository.readPdfStringData(data: pdfString, day: Int32(day), month: Int32(month), year: Int32(year))
        } else {
            throw NSError(domain: "No Data Found", code: 404)
        }
    }
}
