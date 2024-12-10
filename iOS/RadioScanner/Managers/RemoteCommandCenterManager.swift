//
//  RemoteCommandCenterManager.swift
//  RadioScanner
//
//  Created by Brendan Perry on 9/19/24.
//
import MediaPlayer

struct RemoteCommandCenterManager {
    let commandCenter = MPRemoteCommandCenter.shared()

    init() {
        commandCenter.playCommand.isEnabled = true
        commandCenter.pauseCommand.isEnabled = true
    }
    
    func addPlayTarget(_ target: @escaping () -> Void) -> Any {
        commandCenter.playCommand.addTarget { event in
            target()
            return .success
        }
    }
    
    func addPauseTarget(_ target: @escaping () -> Void) -> Any {
        return commandCenter.pauseCommand.addTarget { event in
            target()
            return .success
        }
    }
    
    func removeTargets(pauseTarget: Any, playTarget: Any) {
        commandCenter.pauseCommand.removeTarget(pauseTarget)
        commandCenter.pauseCommand.removeTarget(playTarget)
    }
}
