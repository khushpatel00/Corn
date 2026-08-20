//
//  LaunchLiveActivity.swift
//  Corn
//
//  Created by khush on 20/08/26.
//

import ActivityKit
import Foundation

func launchLiveActivity() throws {
    guard ActivityAuthorizationInfo().areActivitiesEnabled else { return }
    let attributes = MusicLiveAttributes()
    let contentState = MusicLiveAttributes.ContentState(title: "Y Que Fue?", progress: 0.23, isPlaying: false)
    let activityContent = ActivityContent(state: contentState, staleDate: nil)
    let activity = try Activity.request(attributes: attributes, content: activityContent)
}

//await activity.update(ActivityContent(
//    state: MusicLiveAttributes.ContentState(
//        title: "Y Que Fue?", progress: 0.7, isPlaying: true
//    ), staleDate: nil
//))
