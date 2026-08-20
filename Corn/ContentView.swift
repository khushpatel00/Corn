//
//  ContentView.swift
//  Corn
//
//  Created by khush on 17/08/26.
//

import SwiftUI
import AVKit
import ActivityKit

struct ContentView: View {
    @State private var host: AVAudioPlayer!
    @State private var albumImage: UIImage?
    @State private var isPlaying = false
    @State private var scaleFactor: CGFloat = 1.0
    @State private var liveScaling: Timer?
    
    @State private var activity: Activity<MusicLiveAttributes>? = nil

    var body: some View {
        VStack {
            if let albumImage {
                Image(uiImage: albumImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .overlay(alignment: .bottomTrailing) {
                        Image(systemName: "waveform")
                            .symbolEffect(.breathe, options: .repeat(.continuous), isActive: isPlaying)
                            .foregroundStyle(.white)
                            .font(isPlaying ? .title : .title3)
                            .padding(isPlaying ? 24 : 16)
                    }
                    .clipShape(.rect(cornerRadius: isPlaying ? 48 : 32))
                    .clipped()
                    .padding(isPlaying ? 16 : 48)
                //                    .scaleEffect(scaleFactor)
            } else {
                Image("GenuineAlbum")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .overlay(alignment: .bottomTrailing) {
                        Image(systemName: "waveform")
                            .symbolEffect(.breathe, options: .repeat(.continuous), isActive: isPlaying)
                            .foregroundStyle(.white)
                            .font(isPlaying ? .title : .title3)
                            .padding(isPlaying ? 24 : 16)
                    }
                    .clipShape(.rect(cornerRadius: isPlaying ? 48 : 32))
                    .clipped()
                    .padding(isPlaying ? 16 : 48)
//                    .scaleEffect(scaleFactor)
            }
//            Text(String(format: "%.4f", scaleFactor))
            
            HStack(spacing: 0) {
                Button(action: {
                    // Previous track
                }, label: {
                    Image(systemName: "backward")
                        .padding(12)
                })
                .buttonStyle(.glass)
                .buttonBorderShape(.circle)

                Button(action: {
                    if isPlaying {
                        host.pause()

                        withAnimation(.easeOut(duration: 0.2)) {
                            isPlaying = false
                            scaleFactor = 1.0
                        }

//                        liveScaling?.invalidate()
//                        liveScaling = nil
                        let state = MusicLiveAttributes.ContentState(title: "Y Que Fue", progress: 0.35, isPlaying: false)
                        let content = ActivityContent(state: state, staleDate: nil)
                        Task {
//                            await activity?.end(using: state, dismissalPolicy: .immediate)
                            await activity?.end(content, dismissalPolicy: .immediate)
                        }
                    } else {
                        host.play()

                        withAnimation(.easeInOut(duration: 0.2)) {
                            isPlaying = true
                        }
                        
                        let attributes = MusicLiveAttributes()
                        let state = MusicLiveAttributes.ContentState(title: "Y Que Fue?", progress: 0.35, isPlaying: true)
                        let content = ActivityContent(state: state, staleDate: nil)

                        activity = try? Activity<MusicLiveAttributes>.request(attributes: attributes, content: content)

                        
//                        startVisualizer()
                    }

                }, label: {
                    Image(systemName: isPlaying ? "pause" : "play")
                        .padding()
                })
                .buttonStyle(.glassProminent)
                .buttonBorderShape(.circle)

                Button(action: {
                    // Next track
                }, label: {
                    Image(systemName: "forward")
                        .padding(12)
                })
                .buttonStyle(.glass)
                .buttonBorderShape(.circle)
            }
        }
        .onAppear {
            guard let sound = Bundle.main.url(
                forResource: "somebanger1",
                withExtension: "mp3"
            ) else {
                print("Audio file not found")
                return
            }

            do {
                host = try AVAudioPlayer(contentsOf: sound)

                // Enable metering before reading audio power.
//                host.isMeteringEnabled = true
                host.prepareToPlay()

            } catch {
                print("Failed to create audio player:", error)
            }

            Task {
                albumImage = await extractAlbumArt(from: sound)
            }
        }
        .onDisappear {
//            liveScaling?.invalidate()
//            liveScaling = nil
            host?.stop()
        }
    }

    private func startVisualizer() {
        liveScaling?.invalidate()

        liveScaling = Timer.scheduledTimer(
            withTimeInterval: 1.0 / 60.0,
            repeats: true
        ) { _ in
            guard let host, host.isPlaying else {
                return
            }

            host.updateMeters()

            let leftPower = host.averagePower(forChannel: 0)

            let rightPower: Float

            if host.numberOfChannels > 1 {
                rightPower = host.averagePower(forChannel: 1)
            } else {
                rightPower = leftPower
            }

            // Average both stereo channels.
            let power = (leftPower + rightPower) / 2

            // Convert dB (-60...0) into a normalized 0...1 value.
            let normalizedPower = max(
                0,
                min(
                    1,
                    (power + 60) / 60
                )
            )

            // Convert the audio level into an album scale.
            //
            // 0.0 power -> 1.00x
            // 1.0 power -> 1.15x
            let newScale = 1.0 + CGFloat(normalizedPower) * 0.50

            DispatchQueue.main.async {
                withAnimation(.easeOut(duration: 0.01)) {
                    scaleFactor = newScale
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
