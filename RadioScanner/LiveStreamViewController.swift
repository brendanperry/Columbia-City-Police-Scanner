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
    let videoPlayer = VLCMediaPlayer()
    let nowPlayingManager = NowPlayingManager()
    let audioSessionManger = AudioSessionManager()
    var remoteCommandCenterManager: RemoteCommandCenterManager?
    let url = URL(string: "https://streams.textmeout.com:8443/stream")!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        remoteCommandCenterManager = RemoteCommandCenterManager(pauseAudio: {
            self.pauseLiveStream()
        }, playAudio: {
            self.playLiveStream()
        })
    }

    @IBAction func playPauseButtonPress(_ sender: Any) {
        if videoPlayer.isPlaying {
            pauseLiveStream()
        } else {
            playLiveStream()
        }
    }
    
    private func pauseLiveStream() {
        playPauseButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
        videoPlayer.stop()
        audioSessionManger.audioStopped()
        nowPlayingManager.removeNowPlaying()
    }
    
    private func playLiveStream() {
        playPauseButton.setImage(UIImage(systemName: "pause.circle"), for: .normal)
        videoPlayer.media = VLCMedia(url: url)
        videoPlayer.play()
        audioSessionManger.setLiveStreamAudio()
        nowPlayingManager.setNowPlayingInfoForLiveStream()
    }
}

