//
//  MediaManager.swift
//  RadioScanner
//
//  Created by Brendan Perry on 12/5/24.
//

import Foundation
import MobileVLCKit
import MediaPlayer

actor MediaManager {
    public static let shared = MediaManager()
    nonisolated public let mediaPlayer = VLCMediaPlayer()

    var currentUrl: URL?
    var pauseTarget: Any?
    var playTarget: Any?
    var playingLivestream = false
    
    private let remoteCommandCenter = RemoteCommandCenterManager()
    private let nowPlayingManager = NowPlayingManager()
    private let audioSessionManager = AudioSessionManager()
    
    private init() { }
    
    /// Passing no URL will play the current URL
    public func play(url: URL?, isLivestream: Bool, wasPaused: @escaping () -> Void, wasResumed: @escaping () -> Void) async {
        playingLivestream = isLivestream
        
        if let url, url != currentUrl {
            await setNewMedia(url: url, isLivestream: isLivestream, title: "Test", wasPaused: wasPaused, wasResumed: wasResumed)
        }
        
        mediaPlayer.play()
        nowPlayingManager.setNowPlayingInfoStarted()
    }
    
    public func pause() async {
        mediaPlayer.pause()
    }
    
    public func stop() async {
        mediaPlayer.stop()
        audioSessionManager.audioStopped()
        currentUrl = nil
        if let pauseTarget = pauseTarget, let playTarget = playTarget {
            remoteCommandCenter.removeTargets(pauseTarget: pauseTarget, playTarget: playTarget)
        }
    }
    
    public func removeMedia() async {
        await stop()
        mediaPlayer.media = nil
    }
    
    private func setNewMedia(url: URL, isLivestream: Bool, title: String, wasPaused: @escaping () -> Void, wasResumed: @escaping () -> Void) async {
        await stop()
        
        if let pauseTarget = pauseTarget, let playTarget = playTarget {
            remoteCommandCenter.removeTargets(pauseTarget: pauseTarget, playTarget: playTarget)
        }
        
        let playTarget = remoteCommandCenter.addPlayTarget { [weak self] in
            wasResumed()
            Task {
                await self?.play(url: url, isLivestream: isLivestream, wasPaused: wasPaused, wasResumed: wasResumed)
            }
        }
        
        let pauseTarget = remoteCommandCenter.addPauseTarget { [weak self] in
            wasPaused()
            self?.mediaPlayer.pause()
        }
        
        self.pauseTarget = pauseTarget
        self.playTarget = playTarget
        
        mediaPlayer.media = VLCMedia(url: url)
        audioSessionManager.setAudioActive()
    }
}
