//
//  AudioSessionManager.swift
//  RadioScanner
//
//  Created by Brendan Perry on 9/19/24.
//
import AVKit

struct AudioSessionManager {
    let session = AVAudioSession.sharedInstance()
    
    func setAudioActive() {
        try? session.setCategory(.playback,
                                 mode: .default,
                                 policy: .longFormAudio)
        try? session.setActive(true)
    }
    
    func audioStopped() {
        try? session.setActive(false)
    }
}
