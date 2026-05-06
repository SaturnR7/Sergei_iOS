//
//  CountdownWidget.swift
//  CountdownWidget
//
//  Created by Hidemasa Kobayashi on 2025/06/21.
//

import WidgetKit
import SwiftUI

struct CountdownWidget: Widget {
    let kind: String = "CountdownWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            CountdownWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies(
            [.systemSmall, .systemMedium, .systemLarge]
        )
    }
}

struct CountdownWidgetEntryView : View {
    var entry: Provider.Entry

    @Environment(\.widgetFamily) var family

    var body: some View {
        switch family {
        case .systemSmall:
            CountdownSmall(entry: entry)
        case .systemMedium:
            CountdownMedium(entry: entry)
        case .systemLarge:
            CountdownLarge(entry: entry)
        default:
            Text("not supported")
        }
    }
}

// MARK: - Small
struct CountdownSmall: View {
    var entry: LaunchTimelineEntry

    var body: some View {
        VStack {
            Spacer()
            HStack {
                VStack(alignment: .leading, spacing: 14) {
                    HStack {
                        Rectangle()
                            .frame(width: 4, height: 46)
                        VStack(alignment: .leading) {
                            if let launches = entry.launches,
                               let firstLaunch = launches.results.first {
                                Text(firstLaunch.name)
                                    .font(.system(size: 10))
                                Text(firstLaunch.net ?? "TBD")
                                    .font(.system(size: 10))
                                Text("T-000:00:00")
                                    .font(.system(size: 16))
                            } else {
                                Text("Loading...")
                                    .font(.system(size: 10))
                                Text("--")
                                    .font(.system(size: 10))
                                Text("T-000:00:00")
                                    .font(.system(size: 16))
                            }
                        }
                    }
                }
                Spacer()
            }
        }
    }
}

// MARK: - Medium
struct CountdownMedium: View {
    var entry: LaunchTimelineEntry

    var body: some View {
        ZStack() {
            Image("img_widget_starship")
                .resizable()
                .scaledToFill()
            VStack {
                Spacer()
                HStack {
                    Rectangle()
                        .frame(width: 4, height: 46)
                        .foregroundStyle(.green)
                    VStack(alignment: .leading) {
                        if let launches = entry.launches, let firstLaunch = launches.results.first {
                            Text(firstLaunch.name)
                                .font(.system(size: 10))
                                .foregroundStyle(.white)
                            Text(firstLaunch.net ?? "TBD")
                                .font(.system(size: 10))
                                .foregroundStyle(.white)
                            Text("T-000:00:00")
                                .font(.system(size: 16))
                                .foregroundStyle(.white)
                        } else {
                            Text("Loading...")
                                .font(.system(size: 10))
                                .foregroundStyle(.white)
                            Text("--")
                                .font(.system(size: 10))
                                .foregroundStyle(.white)
                            Text("T-000:00:00")
                                .font(.system(size: 16))
                                .foregroundStyle(.white)
                        }
                    }
                    Spacer()
                }
                Spacer().frame(height: 24)
            }
        }
    }
}

// MARK: - Large
struct CountdownLarge: View {
    var entry: LaunchTimelineEntry

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 14) {
                HStack {
                    Rectangle()
                        .frame(width: 4, height: 80)
                    VStack(alignment: .leading) {
                        if let launches = entry.launches, let firstLaunch = launches.results.first {
                            Text(firstLaunch.name ?? "Unknown")
                            Text(firstLaunch.net ?? "TBD")
                            Text("T-000:00:00")
                                .font(.system(size: 26))
                        } else {
                            Text("Loading...")
                            Text("--")
                            Text("T-000:00:00")
                                .font(.system(size: 26))
                        }
                    }
                }
                if let launches = entry.launches {
                    ForEach(Array(launches.results.prefix(4).enumerated()), id: \.offset) { index, launch in
                        CountdownLargeReady(launch: launch)
                    }
                } else {
                    ForEach(0..<4) { _ in
                        CountdownLargeReady(launch: nil)
                    }
                }
            }
            Spacer()
        }
    }
}

struct CountdownLargeReady: View {
    var launch: Launch?

    var body: some View {
        HStack {
            Rectangle()
                .frame(width: 4, height: 40)
            VStack(alignment: .leading) {
                if let launch = launch {
                    Text(launch.name ?? "Unknown")
                    Text(launch.net ?? "TBD")
                } else {
                    Text("Loading...")
                    Text("--")
                }
            }
        }
    }
}

// MARK: - Preview
@available(iOS 17.0, *)
#Preview(as: .systemSmall) {
    CountdownWidget()
} timeline: {
    LaunchTimelineEntry(date: .now, launches: nil)
    LaunchTimelineEntry(date: .now, launches: nil)
}


@available(iOS 17.0, *)
#Preview(as: .systemMedium) {
    CountdownWidget()
} timeline: {
    LaunchTimelineEntry(date: .now, launches: nil)
}

@available(iOS 17.0, *)
#Preview(as: .systemLarge) {
    CountdownWidget()
} timeline: {
    LaunchTimelineEntry(date: .now, launches: nil)
}
