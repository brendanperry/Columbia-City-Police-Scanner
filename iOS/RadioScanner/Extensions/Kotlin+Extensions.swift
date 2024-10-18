//
//  Kotlin+Extensions.swift
//  RadioScanner
//
//  Created by Brendan Perry on 9/23/24.
//

import Foundation
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

extension KotlinArray<Recording> {
    func toArray() -> [Recording] {
        var swiftArray = [Recording]()
        
        var i: Int32 = 0
        while (i < self.size) {
            if let recording = self.get(index: i) {
                swiftArray.append(recording)
            }
            
            i += 1
        }
        
        return swiftArray
    }
}

//extension KotlinArray {
//    func toRecordingArray() -> [Recording] {
//        var swiftArray = [Recording]()
////        var i: Int32 = 0
////        while (i < self.size) {
////            let value = self.get(index: i)
////            
////            if let recording = value as? Recording {
////                swiftArray.append(recording)
////            }
////            
////            i += 1
////        }
////        
//        return swiftArray
//    }
//}
