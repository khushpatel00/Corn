//
//  LiveActivity.swift
//  Corn
//
//  Created by khush on 20/08/26.
//

import ActivityKit
import Foundation

public struct MusicLiveAttributes: ActivityAttributes, Hashable {
    public struct ContentState: Hashable, Codable {
        var title: String
        var progress: Float
        var isPlaying: Bool
    }
}
