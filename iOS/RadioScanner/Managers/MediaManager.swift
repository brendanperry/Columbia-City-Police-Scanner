//
//  MediaManager.swift
//  RadioScanner
//
//  Created by Brendan Perry on 12/5/24.
//

import Foundation
import MobileVLCKit
import MediaPlayer

actor MediaManagerActor {
    var currentUrl: URL?
    var pauseTarget: Any?
    var playTarget: Any?
    var playingLivestream = false

    func setCurrentUrl(_ url: URL?) {
        currentUrl = url
    }
    
    func setPauseTarget(_ target: Any) {
        pauseTarget = target
    }
    
    func setPlayTarget(_ target: Any) {
        playTarget = target
    }
    
    func setPlayingLivestream(_ playingLivestream: Bool) {
        self.playingLivestream = playingLivestream
    }
}

struct MediaManager {
    public static let shared = MediaManager()
    public let mediaPlayer = VLCMediaPlayer()

    let actor = MediaManagerActor()
    private let remoteCommandCenter = RemoteCommandCenterManager()
    private let nowPlayingManager = NowPlayingManager()
    private let audioSessionManager = AudioSessionManager()
    
    private init() { }
    
    /// Passing no URL will play the current URL
    public func play(url: URL?, isLivestream: Bool, wasPaused: @escaping () -> Void, wasResumed: @escaping () -> Void) async {
        let currentUrl = await actor.currentUrl
        await actor.setPlayingLivestream(isLivestream)
        
        if let url, url != currentUrl {
            await setNewMedia(url: url, isLivestream: isLivestream, wasPaused: wasPaused, wasResumed: wasResumed)
        }
        
        mediaPlayer.play()
    }
    
    public func pause() async {
        mediaPlayer.pause()
    }
    
    public func stop() async {
        mediaPlayer.stop()
        audioSessionManager.audioStopped()
        await actor.setCurrentUrl(nil)
        if let pauseTarget = await actor.pauseTarget, let playTarget = await actor.playTarget {
            remoteCommandCenter.removeTargets(pauseTarget: pauseTarget, playTarget: playTarget)
        }
    }
    
    private func setNewMedia(url: URL, isLivestream: Bool, wasPaused: @escaping () -> Void, wasResumed: @escaping () -> Void) async {
        await stop()
        
        
        if let pauseTarget = await actor.pauseTarget, let playTarget = await actor.playTarget {
            remoteCommandCenter.removeTargets(pauseTarget: pauseTarget, playTarget: playTarget)
        }
        
        let playTarget = remoteCommandCenter.addPlayTarget {
            wasResumed()
            Task {
                await play(url: url, isLivestream: isLivestream, wasPaused: wasPaused, wasResumed: wasResumed)
            }
        }
        
        let pauseTarget = remoteCommandCenter.addPauseTarget {
            wasPaused()
            mediaPlayer.pause()
        }
        
        await actor.setPauseTarget(pauseTarget)
        await actor.setPlayTarget(playTarget)
        
        mediaPlayer.media = VLCMedia(url: url)
        audioSessionManager.setLiveStreamAudio()
        nowPlayingManager.setNowPlayingInfoForLiveStream()
    }
}
