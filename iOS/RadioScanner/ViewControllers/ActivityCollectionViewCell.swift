//
//  ActivityCollectionViewCell.swift
//  RadioScanner
//
//  Created by Brendan Perry on 9/22/24.
//

import UIKit
import shared

class ActivityCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var listenButton: UIButton!
    @IBOutlet weak var nature: UILabel!
    
    func configure(with activity: ReportedActivity) {
        time.text = "12:00 PM"
        location.text = activity.address
        nature.text = activity.nature
    }
}
