//
//  RemoteCommandCenterManager.swift
//  RadioScanner
//
//  Created by Brendan Perry on 9/19/24.
//
import MediaPlayer

struct RemoteCommandCenterManager {
    let commandCenter = MPRemoteCommandCenter.shared()
    let playAudio: () -> Void
    let pauseAudio: () -> Void

    init(pauseAudio: @escaping () -> Void, playAudio: @escaping () -> Void) {
        self.playAudio = playAudio
        self.pauseAudio = pauseAudio
        
        commandCenter.playCommand.isEnabled = true
        commandCenter.pauseCommand.isEnabled = true
        
        commandCenter.playCommand.addTarget { event in
            playAudio()
            return .success
        }
        commandCenter.pauseCommand.addTarget { event in
            pauseAudio()
            return .success
        }
    }
}
