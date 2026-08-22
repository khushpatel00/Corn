//
//  HostController.swift
//  Corn
//
//  Created by khush on 22/08/26.
//

import Foundation
import SwiftUI
import AVKit
import ActivityKit
import Combine

final class HostController: ObservableObject {
	private var host: AVAudioPlayer!
	@Published private(set) var albumImage: UIImage?
	@Published private(set) var isPlaying = false
	@Published private(set) var scaleFactor: CGFloat = 1.0
	private var activity: Activity<MusicLiveAttributes>? = nil
	@Published public var volume: CGFloat = 1
	
	// remember: this needs to be initialized explicetely at ContentView, or will crash
	func InitializeSequence() {
		guard let sound = Bundle.main.url(
			forResource: "somebanger3",
			withExtension: "mp3"
		) else {
			print("Audio file not found")
			return
		}
		do {
			host = try AVAudioPlayer(contentsOf: sound)
			//host.isMeteringEnabled = true
			host.prepareToPlay()
			
		} catch {
			print("Failed to create audio player:", error)
		}
	}
	
	public func play () {
		
		host.play()
		isPlaying = true
		
		let attributes = MusicLiveAttributes()
		let state = MusicLiveAttributes.ContentState(title: "Y Que Fue?", progress: 0.35, isPlaying: true)
		let content = ActivityContent(state: state, staleDate: nil)
		
		activity = try? Activity<MusicLiveAttributes>.request(attributes: attributes, content: content)
	}
	
	public func play (at time: TimeInterval) {
		
		host.play(atTime: time)
		isPlaying = true
		
		let attributes = MusicLiveAttributes()
		let state = MusicLiveAttributes.ContentState(title: "Y Que Fue?", progress: 0.35, isPlaying: true)
		let content = ActivityContent(state: state, staleDate: nil)
		
		activity = try? Activity<MusicLiveAttributes>.request(attributes: attributes, content: content)
	}
	
	public func pause () {
		
		host.pause()
		isPlaying = false
		
		let state = MusicLiveAttributes.ContentState(title: "Y Que Fue", progress: 0.35, isPlaying: false)
		let content = ActivityContent(state: state, staleDate: nil)
		Task {
			//await activity?.end(using: state, dismissalPolicy: .immediate)
			await activity?.end(content, dismissalPolicy: .immediate)
		}
	}
	
}
