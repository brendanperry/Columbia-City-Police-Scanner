//
//  URLRequest+Extensions.swift
//  RadioScanner
//
//  Created by Brendan Perry on 9/22/24.
//

import Foundation

extension URLRequest {
    func addingCommonHeaders() -> URLRequest {
        var request = self
        request.addValue("Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:60.0) Gecko/20100101 Firefox/60.0", forHTTPHeaderField: "User-Agent")
        request.addValue("gzip, deflate", forHTTPHeaderField: "Accept-Encoding")
        request.addValue("text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", forHTTPHeaderField: "Accept")
        request.addValue("en-US,en;q=0.5", forHTTPHeaderField: "Accept-Language")
        request.addValue("keep-alive", forHTTPHeaderField: "Connection")
        request.addValue("1", forHTTPHeaderField: "Upgrade-Insecure-Requests")
        
        return request
    }
}
