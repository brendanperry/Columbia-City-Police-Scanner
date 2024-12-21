//
//  NowPlayingManager.swift
//  RadioScanner
//
//  Created by Brendan Perry on 9/19/24.
//
import MediaPlayer

extension UIImage {
    func imageWith(newSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: newSize)
        let image = renderer.image { _ in
            self.draw(in: CGRect.init(origin: CGPoint.zero, size: newSize))
        }
        return image.withRenderingMode(self.renderingMode)
    }
}

struct NowPlayingManager {
    let nowPlayingInfoCenter = MPNowPlayingInfoCenter.default()
    
    func setNowPlayingInfoStarted() {
        var nowPlayingInfo = nowPlayingInfoCenter.nowPlayingInfo ?? [String: Any]()
        
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = 0
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = 1

        if let albumArt = UIImage(named: "NowPlaying") {
            nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: albumArt.size, requestHandler: { imageSize in
                return albumArt.imageWith(newSize: imageSize)
            })
        }

        nowPlayingInfoCenter.nowPlayingInfo = nowPlayingInfo
    }
    
    func set(title: String) {
        var nowPlayingInfo = nowPlayingInfoCenter.nowPlayingInfo ?? [String: Any]()
        nowPlayingInfo[MPMediaItemPropertyTitle] = title
        nowPlayingInfoCenter.nowPlayingInfo = nowPlayingInfo
    }
    
    func set(duration: Int?) {
        var nowPlayingInfo = nowPlayingInfoCenter.nowPlayingInfo ?? [String: Any]()
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = duration
        nowPlayingInfoCenter.nowPlayingInfo = nowPlayingInfo
    }
    
    func seek(duration: Int?) {
        var nowPlayingInfo = nowPlayingInfoCenter.nowPlayingInfo ?? [String: Any]()
        if let duration {
            nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = duration
            nowPlayingInfo[MPNowPlayingInfoPropertyIsLiveStream] = false
        } else {
            nowPlayingInfo[MPNowPlayingInfoPropertyIsLiveStream] = true
        }
    }
    
    func removeNowPlaying() {
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nil
    }
}
