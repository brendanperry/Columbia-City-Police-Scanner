//
//  ArchiveCollectionViewCell.swift
//  RadioScanner
//
//  Created by Brendan Perry on 10/20/24.
//

import UIKit
import shared

class ArchiveCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var time: UILabel!
    var playRecording: ((String) -> Void)?
    var recording: Recording?
    
    func configure(with recording: Recording, playRecording: @escaping (String) -> Void) {
        self.recording = recording
        self.playRecording = playRecording
        time.text = recording.title
    }
    
    @IBAction func listenButtonPress(_ sender: Any) {
        playRecording?(recording?.id ?? "")
    }
}
