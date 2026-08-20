//
//  LiveControlsLiveActivity.swift
//  LiveControls
//
//  Created by khush on 20/08/26.
//

import ActivityKit
import WidgetKit
import SwiftUI

//struct LiveControlsAttributes: ActivityAttributes {
//    public struct ContentState: Codable, Hashable {
//        // Dynamic stateful properties about your activity go here!
//        var emoji: String
//    }
//
//    // Fixed non-changing properties about your activity go here!
//    var name: String
//}

struct LiveControlsLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(
            for: MusicLiveAttributes.self
        ) { context in
            MusicLiveWidgetView(context: context)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom")
                }
            } compactLeading: {
                Text("CL")
            } compactTrailing: {
                Text("CT")
            } minimal: {
                Text("M")
            }
        }
    }
}


struct MusicLiveWidgetView: View {
    let context: ActivityViewContext<MusicLiveAttributes>
    
    var body: some View {
        Text("Y Que Fue?")
            .font(.title)
        Text("Pause")
            .foregroundStyle(.secondary)
    }
}



//extension LiveControlsAttributes {
//    fileprivate static var preview: LiveControlsAttributes {
//        LiveControlsAttributes(name: "World")
//    }
//}

//extension LiveControlsAttributes.ContentState {
//    fileprivate static var smiley: LiveControlsAttributes.ContentState {
//        LiveControlsAttributes.ContentState(emoji: "😀")
//     }
//     
//     fileprivate static var starEyes: LiveControlsAttributes.ContentState {
//         LiveControlsAttributes.ContentState(emoji: "🤩")
//     }
//}
