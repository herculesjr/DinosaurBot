//
//  GameHandler.swift
//  DinosaurBot
//
//  Created by Hercules Junior on 18/05/18.
//  Copyright © 2018 Hercules Junior. All rights reserved.
//

import Cocoa
import CoreGraphics

final class GameHandler: NSObject {
    
    private let dinosaurColor = NSColor(red: 0x53 / 0xFF, green: 0x53 / 0xFF, blue: 0x53 / 0xFF, alpha: 1)
    
    func send(keyStroke: Key) {
        let src = CGEventSource(stateID: CGEventSourceStateID.combinedSessionState)
        
        let pressedKey = CGEvent(keyboardEventSource: src, virtualKey: keyStroke.rawValue, keyDown: true)
        let releasedKey = CGEvent(keyboardEventSource: src, virtualKey: keyStroke.rawValue, keyDown: false)
        let loc = CGEventTapLocation.cgSessionEventTap
        
        pressedKey?.post(tap: loc)
        releasedKey?.post(tap: loc)
    }
}
