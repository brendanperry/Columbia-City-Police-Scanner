//
//  Kotlin+Extensions.swift
//  RadioScanner
//
//  Created by Brendan Perry on 9/23/24.
//

import shared

extension KotlinByteArray {
    func toData() -> Data {
        let iterator = self.iterator()
        
        var bytes = [Int8]()
        while(iterator.hasNext()) {
            bytes.append(iterator.nextByte())
        }
        
        return Data(bytes: bytes, count: Int(self.size))
    }
}
