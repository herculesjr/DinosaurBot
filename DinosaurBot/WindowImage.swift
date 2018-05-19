//
//  WindowImage.swift
//  DinosaurBot
//
//  Created by Hercules Junior on 18/05/18.
//  Copyright © 2018 Hercules Junior. All rights reserved.
//

import Foundation
import CoreGraphics

final class WindowImage {
    
    func searchWindow(withScreenName screenName: String) -> WindowInfo? {
        guard let windowList = CGWindowListCopyWindowInfo(.optionOnScreenOnly, kCGNullWindowID) as? [[String: Any]] else { return nil }
        for window in windowList {
            guard let sharingState = window[kCGWindowSharingState as String] as? NSNumber,
                CGWindowSharingType(rawValue: UInt32(truncating: sharingState)) != .none,
                let name = window[kCGWindowOwnerName as String] as? String,
                name == screenName,
                let boundsObject =  window[kCGWindowBounds as String],
                let bounds = CGRect(dictionaryRepresentation: boundsObject as! CFDictionary),
                let windowID = window[kCGWindowNumber as String] as? CGWindowID
                else { continue }
            return WindowInfo(windowID: windowID, bounds: bounds)
        }
        return nil
    }
    
    func getImage(forWindow window: WindowInfo) -> CGImage? {
        guard let image = CGWindowListCreateImage(window.bounds, [.optionIncludingWindow], window.windowID, .bestResolution) else { return nil }
        return image
    }
}
