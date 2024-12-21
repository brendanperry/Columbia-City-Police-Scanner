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
    
    let mediaManager = MediaManager.shared
    let nowPlayingManager = NowPlayingManager()
    
    var selectedMedia: URL?
    var recording: Recording?
    
    func mediaPlayerTimeChanged(_ aNotification: Notification!) {
        currentTime.text = mediaManager.mediaPlayer.time.stringValue
        maxTime.text = mediaManager.mediaPlayer.media.length.stringValue
        nowPlayingManager.set(duration: mediaManager.mediaPlayer.media.length.value.intValue / 1000)

        timelineSlider.setValue(mediaManager.mediaPlayer.position, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mediaManager.mediaPlayer.delegate = self
    }
    
    func setRecording(recording: Recording, for activity: ReportedActivity?) {
        self.recording = recording
        
        if let activity {
            audioTitle.text = activity.nature + " at " + activity.displayTime()
            locationLabel.text = activity.address ?? ""
            timeLabel.text = recording.title
            nowPlayingManager.set(title: audioTitle.text ?? "")
        } else {
            audioTitle.text = ""
            locationLabel.text = ""
            timeLabel.text = recording.title
            nowPlayingManager.set(title: recording.title)
        }
        
        let totalMinutes = recording.endTime.minute - recording.startTime.minute
        let placement = Float((activity?.dateTime.minute ?? 0 - 2) - recording.startTime.minute) / Float(totalMinutes + 1)
        
        let media = updateMedia(placement: max(0, placement))
        
        Task {
            await playAudio(withPosition: !silenceRemovedToggle.isOn ? placement : 0, url: media)
        }
    }
    
    func updateMedia(placement: Float?) -> URL? {
        guard let recording else { return nil }
        var resource = "https://scanwc.com/assets/php/archives/archive_download.php?id=\(recording.id)"
        
        if silenceRemovedToggle.isOn {
            resource += "&rs=yes"
        } else {
            mediaManager.mediaPlayer.position = placement ?? 0.0
        }
        
        guard let url = URL(string: resource) else { return nil }
        
        playButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
        currentTime.text = "--:--"
        maxTime.text = "--:--"
        timelineSlider.setValue(0, animated: true)
        
        return url
    }

    @IBAction func sliderMoved(_ sender: Any) {
        let newPosition = timelineSlider.value / timelineSlider.maximumValue
        
        mediaManager.mediaPlayer.position = newPosition
    }
    
    @IBAction func playButtonPressed(_ sender: Any) {
        if mediaManager.mediaPlayer.isPlaying {
            Task {
                await mediaManager.pause()
                playButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
            }
        } else {
            Task {
                await playAudio(withPosition: nil, url: nil)
            }
        }
    }
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        Task {
            let url = updateMedia(placement: nil)
            await playAudio(withPosition: nil, url: url)
        }
    }
    
    func playAudio(withPosition position: Float?, url: URL?) async {
        await mediaManager.play(url: url, isLivestream: false, wasPaused: { [weak self] in
            self?.playButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
        }, wasResumed: { [weak self] in
            self?.playButton.setImage(UIImage(systemName: "pause.circle"), for: .normal)
        })
        
        if let position {
            mediaManager.mediaPlayer.position = position
        }

        playButton.setImage(UIImage(systemName: "pause.circle"), for: .normal)
    }
}
