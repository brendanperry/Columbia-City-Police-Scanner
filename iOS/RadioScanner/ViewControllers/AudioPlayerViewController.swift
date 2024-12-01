//
//  AudioPlayerViewController.swift
//  RadioScanner
//
//  Created by Brendan Perry on 10/21/24.
//

import UIKit
import MobileVLCKit
import shared

class AudioPlayerViewController: UIViewController, VLCMediaPlayerDelegate {
    @IBOutlet weak var currentTime: UILabel!
    @IBOutlet weak var maxTime: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var timelineSlider: UISlider!
    @IBOutlet var silenceRemovedToggle: UISwitch!
    @IBOutlet weak var audioTitle: UILabel!
    
    let audioPlayer = VLCMediaPlayer()
    
    var selectedMedia: URL?
    var recording: Recording?
    
    func mediaPlayerTimeChanged(_ aNotification: Notification!) {
        currentTime.text = audioPlayer.time.stringValue
        maxTime.text = audioPlayer.media.length.stringValue
        
        timelineSlider.setValue(audioPlayer.position, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        audioPlayer.delegate = self
    }
    
    func setRecording(recording: Recording, for activity: ReportedActivity?) {
        self.recording = recording
        
        if let activity {
            audioTitle.text = activity.nature + " at " + activity.displayTime()
            locationLabel.text = activity.address ?? ""
            timeLabel.text = recording.title
        } else {
            audioTitle.text = ""
            locationLabel.text = ""
            timeLabel.text = recording.title
        }
        
        let totalMinutes = recording.endTime.minute - recording.startTime.minute
        let placement = Float((activity?.dateTime.minute ?? 0 - 2) - recording.startTime.minute) / Float(totalMinutes + 1)
        
        updateMedia(placement: max(0, placement))
        
        playAudio(withPosition: !silenceRemovedToggle.isOn ? placement : 0)
    }
    
    func updateMedia(placement: Float?) {
        guard let recording else { return }
        var resource = "https://scanwc.com/assets/php/archives/archive_download.php?id=\(recording.id)"
        
        if silenceRemovedToggle.isOn {
            resource += "&rs=yes"
        } else {
            audioPlayer.position = placement ?? 0.0
        }
        
        guard let url = URL(string: resource) else { return }
        audioPlayer.media = VLCMedia(url: url)
        
        playButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
        currentTime.text = "--:--"
        maxTime.text = "--:--"
        timelineSlider.setValue(0, animated: true)
    }

    @IBAction func sliderMoved(_ sender: Any) {
        let newPosition = timelineSlider.value / timelineSlider.maximumValue
        
        audioPlayer.position = newPosition
    }
    
    @IBAction func playButtonPressed(_ sender: Any) {
        if audioPlayer.isPlaying {
            audioPlayer.pause()
            playButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
        } else {
            playAudio(withPosition: nil)
        }
    }
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        updateMedia(placement: nil)
        playAudio(withPosition: nil)
    }
    
    func playAudio(withPosition position: Float?) {
        audioPlayer.play()
        
        if let position {
            audioPlayer.position = position
        }

        playButton.setImage(UIImage(systemName: "pause.circle"), for: .normal)
    }
}
