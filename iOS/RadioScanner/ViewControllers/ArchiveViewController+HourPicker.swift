//
//  ArchiveViewController+HourPickerDataSource.swift
//  RadioScanner
//
//  Created by Brendan Perry on 9/26/24.
//

import UIKit

extension ArchiveViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 24
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        titleForRow row: Int,
        forComponent component: Int
    ) -> String? {
        if row < 12 {
            if row == 0 {
                return "12 AM"
            }
            return "\(row) AM"
        } else {
            if row == 12 {
                return "12 PM"
            }
            return "\(row - 12) PM"
        }
    }
}
