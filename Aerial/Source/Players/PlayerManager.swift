//
//  PlayerManager.swift
//  Aerial
//
//  Created by John Coates on 9/15/17.
//  Copyright © 2017 John Coates. All rights reserved.
//

import Foundation
import AppKit

protocol AerialPlayer: class {
    var delegate: AerialPlayerDelegate? { get set }
    var videoURL: URL? { get set }
    func play(URL: URL)
    func play()
    func pause()
    func playNextVideo()
    
    func newLayer() -> CALayer
}

protocol AerialPlayerLayer: class {
    var player: AerialPlayer? { get }
    var caLayer: CALayer { get }
}

protocol AerialPlayerDelegate: class {
    func playerFailedToPlayToEnd(_ player: AerialPlayer)
    func playerDidReachEndEnd(_ player: AerialPlayer)
}

class PlayerManager {
    static weak var previewPlayer: AerialPlayer?
    static var sharedPlayer: AerialPlayer?
    
    class func player(forView view: AerialView? = nil) -> AerialPlayer {
        if Preferences.shared.differentAerialsOnEachDisplay == false,
            let player = sharedPlayer {
            return player
        }
        
        if let view = view,
            let previewPlayer = previewPlayer,
            view.isPreview == false {
            return previewPlayer
        }
        
        let player = AerialPlayerAVKit()
        
        if let view = view, view.isPreview {
            previewPlayer = player
        }
        
        if Preferences.shared.differentAerialsOnEachDisplay == false {
            sharedPlayer = player
        }
        
        return player
    }
}
