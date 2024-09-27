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
    var openArchives: (() -> Void)?
    
    func configure(with activity: ReportedActivity, openArchives: @escaping () -> Void) {
        self.openArchives = openArchives
        time.text = activity.displayTime()
        location.text = activity.address
        nature.text = activity.nature
    }
    
    @IBAction func listenButtonPress(_ sender: Any) {
        openArchives?()
        print(time.text ?? "oof")
    }
}
