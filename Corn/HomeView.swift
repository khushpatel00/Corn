//
//  HomeView.swift
//  Corn
//
//  Created by khush on 22/08/26.
//

import SwiftUI

struct HomeView: View {
	@EnvironmentObject var host: HostController
	@Binding var isPlayerVisible: Bool
    var body: some View {
		TabView{
			Tab("Tab 1", systemImage: "house") {
					Text("Tab 1")
			}
			Tab("Tab 2", systemImage: "airplane.ticket") {
				Text("Tab 2")
				Button("Toggle isPlayerVisible animated") {
					withAnimation {
						isPlayerVisible.toggle()
					}
					print("switched view \(isPlayerVisible)")
				}
				Button("Toggle isPlayerVisible static") {
					isPlayerVisible.toggle()
					print("switched view \(isPlayerVisible)")
				}
				Text(String(isPlayerVisible))
			}
		}
		.tabBarMinimizeBehavior(.onScrollDown)
		.tabViewBottomAccessory {
			HStack {
				Image(systemName: "music.note")
					.onTapGesture {
						withAnimation {
							isPlayerVisible.toggle()
						}
					}
				HStack {
					VStack (alignment: .leading, spacing: 0) {
						Text("Now Playing")
//							.font(.caption2)
							.font(.custom("", size: 9, relativeTo: .caption2))
							.fontWeight(.light)
							.fontDesign(.rounded)
						Text("Sau Paulo")
							.font(.title3)
							.fontWidth(.expanded)
							.fontWeight(.regular)
					}
					.padding(8)
					Spacer()
				}
				Spacer()
				Button(action: {
					if host.isPlaying {
						host.play()
					} else {
						host.pause()
					}
				}) {
					Image(systemName: host.isPlaying ? "pause.fill" : "play.fill")
						.transition(.symbolEffect)
				}
			}
			.padding()
			.background(.ultraThinMaterial)
			.clipShape(.capsule)
		}
    }
}

#Preview {
	@Previewable @State var isVisible: Bool = false
    HomeView(isPlayerVisible: $isVisible)
}
