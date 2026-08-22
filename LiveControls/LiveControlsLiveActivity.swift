//
//  LiveControlsLiveActivity.swift
//  LiveControls
//
//  Created by khush on 20/08/26.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct LiveControlsLiveActivity: Widget {
    let albumArt: String = "GenuineAlbumv2"
    
    var body: some WidgetConfiguration {
        ActivityConfiguration(
            for: MusicLiveAttributes.self
        ) { context in
            //            MusicLiveWidgetView(context: context)
            MusicLiveWidgetView()
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading, priority: 2) {
                    ZStack {
                        Image(albumArt)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .blur(radius: 20)
                            .scaleEffect(0.6)
                            .opacity(0.8)
                        Image(albumArt)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .blur(radius: 20)
                            .scaleEffect(0.6)
                            .rotationEffect(.degrees(180))
                            .opacity(0.8)
//                            .ignoresSafeArea() // maybe can work
                        
                        Image(albumArt)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(.containerRelative)
                            .padding(32) // without this, content margin snaps this to edges
                    }
                    .ignoresSafeArea()
                }
                .contentMargins(.all, 0)
                DynamicIslandExpandedRegion(.trailing, priority: 0) {
                    VStack (alignment: .trailing) {
                        VStack (alignment: .trailing) {
                            Text("Sau Paulo")
                                .font(.title3)
                                .foregroundStyle(.white)
                                .fontWeight(.semibold)
                                .fontWidth(.expanded)
                                .lineLimit(1)
                                .minimumScaleFactor(0.5)
                            Text("The Weeknd")
                                .foregroundStyle(.tertiary)
                                .font(.caption)
                                .multilineTextAlignment(.trailing)
                        }
                        .padding(.trailing)
                        .padding(.top, 12)
                        
                        Spacer()
                        Image(systemName: "pause")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                            .padding(.bottom, 16)
                    }
                }
            } compactLeading: {
                Image(albumArt)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(.containerRelative)
                    .frame(width: 25, height: 20)
                
            } compactTrailing: {
                Image(systemName: "waveform")
            } minimal: {
                Image(albumArt)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 25, height: 20)
                    .scaleEffect(1.25)
            }
//            .contentMargins(.all, 0, for: .expanded)
        }
    }
}


struct MusicLiveWidgetView: View {
//    let context: ActivityViewContext<MusicLiveAttributes>
    
    let albumArt: String = "GenuineAlbumv2"
    
    var body: some View {
        ZStack (alignment: .bottomLeading) {
            Image(albumArt)
                .resizable()
                .scaleEffect(2)
//                    .offset(x: -50)
                .blur(radius: 32)
                .opacity(0.32)
            HStack {
                ZStack (alignment: .trailing) {
                    Image(albumArt)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaleEffect(2)
                        .offset(x: -50)
                        .blur(radius: 32)
                    Image(albumArt)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(.containerRelative)
                        .mask {
                            LinearGradient(colors: [.white, .clear], startPoint: .leading, endPoint: .trailing)
                        }
                }
                Spacer()
                VStack {
                    
                    Text("Sau Paulo")
                        .font(.title3)
                        .foregroundStyle(.foreground)
                        .fontWeight(.semibold)
                        .fontWidth(.expanded)
                    
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "pause")
                            .padding(8)
                    })
                    .buttonStyle(.plain)
                }
            }
            .padding(.trailing)
            
            Color.white
                .frame(width: 70, height: 5)
                .opacity(0.5)
                .clipShape(.containerRelative)
            
        }
    }
}

#Preview (as: .dynamicIsland(.expanded), using: MusicLiveAttributes()) {
    LiveControlsLiveActivity()
} contentStates: {
    MusicLiveAttributes.ContentState(title: "Y Que Fue?", progress: 0.2, isPlaying: true)
}

#Preview (as: .content, using: MusicLiveAttributes()) {
    LiveControlsLiveActivity()
} contentStates: {
    MusicLiveAttributes.ContentState(title: "Y Que Fue?", progress: 0.2, isPlaying: true)
}
