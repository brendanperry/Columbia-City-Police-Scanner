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
    var activity: ReportedActivity?
    var listenToAudio: ((ReportedActivity?) -> Void)?
    
    func configure(with activity: ReportedActivity, listenToAudio: @escaping (ReportedActivity?) -> Void) {
        self.activity = activity
        self.listenToAudio = listenToAudio
        time.text = activity.displayTime()
        location.text = activity.address
        nature.text = activity.nature
    }
    
    @IBAction func listenButtonPress(_ sender: Any) {
        listenToAudio?(activity)
    }
}
