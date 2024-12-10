//
//  ViewController.swift
//  RadioScanner
//
//  Created by Brendan Perry on 9/19/24.
//

import UIKit
import MobileVLCKit
import AVKit
import MediaPlayer

class LiveStreamViewController: UIViewController {
    @IBOutlet weak var playPauseButton: UIButton!
    let mediaManager = MediaManager.shared
    let url = URL(string: "https://streams.textmeout.com:8443/stream")!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func playPauseButtonPress(_ sender: Any) {
        Task {
            if mediaManager.mediaPlayer.isPlaying {
                await pauseLiveStream()
            } else {
                await playLiveStream()
            }
        }
    }
    
    private func pauseLiveStream() async {
        playPauseButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
        await mediaManager.stop()
    }
    
    private func playLiveStream() async {
        playPauseButton.setImage(UIImage(systemName: "pause.circle"), for: .normal)
        await mediaManager.play(url: url, isLivestream: true, wasPaused: { [weak self] in
            self?.playPauseButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
        }, wasResumed: { [weak self] in
            self?.playPauseButton.setImage(UIImage(systemName: "pause.circle"), for: .normal)
        })
    }
}

