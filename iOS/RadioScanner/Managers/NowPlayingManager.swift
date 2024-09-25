//
//  NowPlayingManager.swift
//  RadioScanner
//
//  Created by Brendan Perry on 9/19/24.
//
import MediaPlayer

struct NowPlayingManager {
    func setNowPlayingInfoForLiveStream() {
        let nowPlayingInfoCenter = MPNowPlayingInfoCenter.default()
        var nowPlayingInfo = nowPlayingInfoCenter.nowPlayingInfo ?? [String: Any]()
        
        
        if let url = URL(string: "https://streams.textmeout.com:8443/stream") {
            nowPlayingInfo[MPNowPlayingInfoPropertyAssetURL] = url
        }
        nowPlayingInfo[MPNowPlayingInfoPropertyIsLiveStream] = true
        
        if let albumArt = UIImage(named: "nic") {
            nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: albumArt.size, requestHandler: { imageSize in
                return albumArt
            })
        }

        nowPlayingInfoCenter.nowPlayingInfo = nowPlayingInfo
        
    }
    
    func removeNowPlaying() {
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nil
    }
}
