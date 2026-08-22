//
//  ContentView.swift
//  Corn
//
//  Created by khush on 17/08/26.
//

import SwiftUI
import ActivityKit
import AVKit

struct ContentView: View {
	@EnvironmentObject var host: HostController
	@State var isPlayerVisible: Bool = false
	
    var body: some View {
		ZStack {
			HomeView(isPlayerVisible: $isPlayerVisible)
			if isPlayerVisible {
				PlayerView(isPlayerVisible: $isPlayerVisible)
					.transition(.move(edge: .bottom).animation(.easeOut))
			}
		}
		.onAppear {
			host.InitializeSequence()
		}
//		.onChange(of: isPlayerVisible) {
//			print("isPlayerVisible: \(isPlayerVisible)")
//		}
    }
}

#Preview {
    ContentView()
}
