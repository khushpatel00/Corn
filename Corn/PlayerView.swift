//
//  PlayerView.swift
//  Corn
//
//  Created by khush on 22/08/26.
//

import SwiftUI
import ActivityKit
import AVKit

struct PlayerView: View {
	@EnvironmentObject var host: HostController
	@Binding var isPlayerVisible: Bool
	
    var body: some View {
		VStack {
			HStack {
				Button(action: {
					withAnimation {
						isPlayerVisible.toggle()
					}
//					print("clicked with internal action")
//					print(isPlayerVisible)
				}, label: {
					Image(systemName: "chevron.down")
//					Text(String(isPlayerVisible).capitalized)
				})
//				.buttonStyle(.glassProminent)
				
				Spacer()
			}
			.padding()
			
			Spacer()
			
			if host.albumImage != nil {
				Image(uiImage: host.albumImage!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .overlay(alignment: .bottomTrailing) {
                        Image(systemName: "waveform")
							.symbolEffect(.breathe, options: .repeat(.continuous), isActive: host.isPlaying)
                            .foregroundStyle(.white)
							.font(host.isPlaying ? .title : .title3)
							.padding(host.isPlaying ? 24 : 16)
                    }
					.clipShape(.rect(cornerRadius: host.isPlaying ? 48 : 32))
                    .clipped()
					.padding(host.isPlaying ? 16 : 48)
                //                    .scaleEffect(scaleFactor)
            } else {
                Image("GenuineAlbumv2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .overlay(alignment: .bottomTrailing) {
                        Image(systemName: "waveform")
							.symbolEffect(.breathe, options: .repeat(.continuous), isActive: host.isPlaying)
                            .foregroundStyle(.white)
							.font(host.isPlaying ? .title : .title3)
							.padding(host.isPlaying ? 24 : 16)
                    }
					.clipShape(.rect(cornerRadius: host.isPlaying ? 48 : 32))
                    .clipped()
					.padding(host.isPlaying ? 16 : 48)
//					.scaleEffect(scaleFactor)
            }
			Text(String(format: "%.4f", host.scaleFactor))
            
            HStack(spacing: 0) {
                Button(action: {
					withAnimation {
						host.pause()
					}
                }, label: {
                    Image(systemName: "backward")
                        .padding(12)
                })
                .buttonStyle(.glass)
                .buttonBorderShape(.circle)

                Button(action: {
					withAnimation {
						if host.isPlaying {
							host.pause()
						} else {
							host.play()
						}
					}
                }, label: {
					Image(systemName: host.isPlaying ? "pause" : "play")
                        .padding()
                })
                .buttonStyle(.glassProminent)
                .buttonBorderShape(.circle)

                Button(action: {
					withAnimation {
						host.pause()
					}
                }, label: {
                    Image(systemName: "forward")
                        .padding(12)
                })
                .buttonStyle(.glass)
                .buttonBorderShape(.circle)
            }
			
			Spacer()
        }
		.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
		.background(Color.white)
    }
}

#Preview {
	ContentView()
}
