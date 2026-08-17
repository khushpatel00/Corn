//
//  ContentView.swift
//  Corn
//
//  Created by khush on 17/08/26.
//

import SwiftUI
import AVKit

struct ContentView: View {
    
    @State var host: AVAudioPlayer!
    @State private var albumImage: UIImage?
    @State private var isPlaying: Bool = false
    
    var body: some View {
        VStack {
                if let albumImage {
                    Image(uiImage: albumImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(.rect(cornerRadius: isPlaying ? 48 : 32))
                        .clipped()
                        .padding(isPlaying ? 16 : 48)
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
                }
            HStack (spacing: 0) {
                Button(action: {
                    
                }, label: {
                    Image(systemName: "backward")
                        .padding(12)
                })
                .buttonStyle(.glass)
                .buttonBorderShape(.circle)
                
                
                Button(action: {
                    if isPlaying {
                        host.pause()
                        withAnimation {
                            isPlaying = false
                        }
                    } else {
                        host.play()
                        withAnimation {
                            isPlaying = true
                        }
                    }
                }, label: {
                    Image(systemName: isPlaying ? "pause" : "play")
                        .padding()
                })
                .buttonStyle(.glassProminent)
                .buttonBorderShape(.circle)
                
                
                Button(action: {
                    
                }, label: {
                    Image(systemName: "forward")
                        .padding(12)
                })
                .buttonStyle(.glass)
                .buttonBorderShape(.circle)
            }
            
            
        }
        .onAppear{
            guard let sound = Bundle.main.url(
                forResource: "somebanger1",
                withExtension: "mp3"
            ) else {
                return
            }
            
            do {
                host = try AVAudioPlayer(contentsOf: sound)
            } catch {
                print(error)
            }
            
            Task {
                albumImage = await extractAlbumArt(from: sound)
            }
        }
    }
}

#Preview {
    ContentView()
}
