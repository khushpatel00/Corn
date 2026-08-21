//
//  LiveControls.swift
//  LiveControls
//
//  Created by khush on 20/08/26.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }

//    func relevances() async -> WidgetRelevances<Void> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct LiveControlsEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            Image("GenuineAlbum")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaleEffect(1.5)
                .blur(radius: 16)
//                .clipShape(.capsule)
            VStack (alignment: .center, spacing: 10) {
                Text("Y Que Fue?")
                    .font(.title3)
                    .fontWeight(.regular)
                    .fontWidth(.expanded)
                    .foregroundStyle(.white)
                Button {
                    
                } label: {
                    Image(systemName: "play")
                        .font(.title3)
                        .foregroundStyle(.white)
                }
                .buttonBorderShape(.circle)
                .buttonStyle(.plain)
            }
        }
    }
}

struct LiveControls: Widget {
    let kind: String = "Corn Standard"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                LiveControlsEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                LiveControlsEntryView(entry: entry)
                //  .padding()
                    .background()
            }
        }
        .configurationDisplayName("Corn Audio")
        .description("Hear the most without opening the app")
    }
}

#Preview(as: .systemExtraLarge) {
    LiveControls()
} timeline: {
    SimpleEntry(date: .now)
}
