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
		ZStack {
			if host.albumImage != nil {
				Image(uiImage: host.albumImage!)
					.resizable()
					.scaledToFill()
					.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
					.clipped()
					.blur(radius: 36)
					.scaleEffect(1.5, anchor: .bottom)
					.offset(y: 80)
					.ignoresSafeArea()
			} else {
				Image("GenuineAlbumv2")
					.resizable()
					.scaledToFill()
					.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
					.clipped()
					.blur(radius: 36)
					.scaleEffect(1.5, anchor: .bottom)
					.offset(y: 80)
					.ignoresSafeArea()
					.opacity(0.5)
				Image("GenuineAlbumv2")
					.resizable()
					.scaledToFill()
					.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
					.clipped()
					.blur(radius: 36)
					.scaleEffect(1.5, anchor: .bottom)
					.offset(y: 80)
					.rotationEffect(.degrees(180))
					.ignoresSafeArea()
					.opacity(0.5)
			}
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
				Group {
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
//							.clipShape(.rect(cornerRadius: host.isPlaying ? 48 : 32))
							.clipShape(.rect(cornerRadius: 32))
							.clipped()
//							.padding(host.isPlaying ? 32 : 48)
							.padding(48)
							.scaleEffect(host.scaleFactor)
					} else {
						Image("GenuineAlbumv2")
							.resizable()
							.aspectRatio(contentMode: .fit)
//							.overlay(alignment: .bottomTrailing) {
//								Image(systemName: "waveform")
//									.symbolEffect(.breathe, options: .repeat(.continuous), isActive: host.isPlaying)
//									.foregroundStyle(.white)
//									.font(host.isPlaying ? .title : .title3)
//									.padding(host.isPlaying ? 24 : 16)
//							}
//							.clipShape(.rect(cornerRadius: host.isPlaying ? 48 : 32))
							.clipShape(.rect(cornerRadius: 32))
							.clipped()
//							.padding(.horizontal, host.isPlaying ? 32 : 48)
							.padding(.horizontal, 48)
							.scaleEffect(host.scaleFactor)
					}
					Text(String(format: "%.4f", host.scaleFactor))
						.font(.caption)
						.foregroundStyle(.tertiary)
						.fontWeight(.bold)
						.fontWidth(.expanded)
						.frame(alignment: .center)
						.padding(12)
						.background(.thinMaterial)
						.clipShape(.capsule)
						.padding(32)
					HStack {
						VStack (alignment: .leading, spacing: 0) {
							Text("Sau Paulo")
								.font(.title)
								.fontWidth(.expanded)
								.fontWeight(.semibold)
								.foregroundStyle(.white)
							Text("The Weeknd")
								.font(.headline)
								.foregroundStyle(.secondary)
								.fontWeight(.semibold)
						}
						.padding(.horizontal, 32)
						Spacer()
					}
				}
				
				Spacer()
				
				HStack(spacing: 12) {
					Button(action: {
						withAnimation {
							host.pause()
						}
					}, label: {
						Image(systemName: "backward.fill")
							.font(.largeTitle)
							.foregroundStyle(.white)
							.foregroundStyle(.secondary)
							.fontWeight(.semibold)
					})
					
					Button(action: {
						withAnimation {
							if host.isPlaying {
								host.pause()
							} else {
								host.play()
							}
						}
					}, label: {
						Image(systemName: host.isPlaying ? "pause.fill" : "play.fill")
							.font(.custom("", fixedSize: 60))
							.foregroundStyle(.white)
//							.fontWeight(.black)
					})
					
					Button(action: {
						withAnimation {
							host.pause()
						}
					}, label: {
						Image(systemName: "forward.fill")
							.font(.largeTitle)
							.foregroundStyle(.white)
							.foregroundStyle(.secondary)
							.fontWeight(.semibold)
					})
				}
				
				Spacer()
			}
		}
		.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
		.background(Color.white)
		.onAppear {
			host.startVisualizer()
		}
    }
}

#Preview {
	ContentView()
}
