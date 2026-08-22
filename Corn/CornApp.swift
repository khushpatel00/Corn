//
//  CornApp.swift
//  Corn
//
//  Created by khush on 17/08/26.
//

import SwiftUI

@main
struct CornApp: App {
	@StateObject private var host = HostController()
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
					.environmentObject(host)
            }
        }
    }
}
