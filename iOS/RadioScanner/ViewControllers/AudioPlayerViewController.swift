//
//  AudioPlayerViewController.swift
//  RadioScanner
//
//  Created by Brendan Perry on 10/21/24.
//

import UIKit
import MobileVLCKit

class AudioPlayerViewController: UIViewController, VLCMediaPlayerDelegate {
    @IBOutlet weak var currentTime: UILabel!
    @IBOutlet weak var maxTime: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet var timelineSlider: UISlider!
    @IBOutlet weak var audioTitle: UILabel!
    
    let audioPlayer = VLCMediaPlayer()
    
    var selectedMedia: URL?
    
    func mediaPlayerTimeChanged(_ aNotification: Notification!) {
        currentTime.text = audioPlayer.time.stringValue
        maxTime.text = audioPlayer.media.length.stringValue
        
        timelineSlider.setValue(audioPlayer.position, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        audioPlayer.delegate = self
        
        if let selectedMedia {
            audioPlayer.media = VLCMedia(url: selectedMedia)
            playAudio()
        }
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
            playAudio()
        }
    }
    
    func playAudio() {
        audioPlayer.play()
        playButton.setImage(UIImage(systemName: "pause.circle"), for: .normal)
    }
}
