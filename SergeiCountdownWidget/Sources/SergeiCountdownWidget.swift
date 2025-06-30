//
//  SergeiCountdownWidget.swift
//  SergeiCountdownWidget
//
//  Created by Hidemasa Kobayashi on 2025/06/21.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), launches: nil)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), launches: nil)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task {
            var entries: [SimpleEntry] = []
            let currentDate = Date()

            do {
                let request = LaunchesRequest()
                let launches = try await APIClient.shared.response(request)

                // 次の5時間分のエントリを作成
                for hourOffset in 0 ..< 5 {
                    let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
                    let entry = SimpleEntry(date: entryDate, launches: launches)
                    entries.append(entry)
                }
            } catch {
                print("❌ API Error: \(error)")
                // エラーの場合は空のデータでエントリを作成
                for hourOffset in 0 ..< 5 {
                    let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
                    let entry = SimpleEntry(date: entryDate, launches: nil)
                    entries.append(entry)
                }
            }

            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
        }
    }

//    func relevances() async -> WidgetRelevances<Void> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let launches: Launches?
}

struct SergeiCountdownWidget: Widget {
    let kind: String = "CountdownWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                CountdownWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                CountdownWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
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
    var entry: SimpleEntry

    var body: some View {
        VStack {
            Spacer()
            HStack {
                VStack(alignment: .leading, spacing: 14) {
                    HStack {
                        Rectangle()
                            .frame(width: 4, height: 46)
                        VStack(alignment: .leading) {
                            if let launches = entry.launches, let firstLaunch = launches.results.first {
                                Text(firstLaunch.name ?? "Unknown")
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
    var entry: SimpleEntry

    var body: some View {
        ZStack {
//            Image("img_widget_starship")
//                .aspectRatio(contentMode: .fill)
            VStack {
                Spacer()
                HStack {
                    VStack(alignment: .leading, spacing: 14) {
                        HStack {
                            Rectangle()
                                .frame(width: 4, height: 46)
                            VStack(alignment: .leading) {
                                if let launches = entry.launches, let firstLaunch = launches.results.first {
                                    Text(firstLaunch.name ?? "Unknown")
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
}

// MARK: - Large
struct CountdownLarge: View {
    var entry: SimpleEntry

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
    SergeiCountdownWidget()
} timeline: {
    SimpleEntry(date: .now, launches: nil)
    SimpleEntry(date: .now, launches: nil)
}


@available(iOS 17.0, *)
#Preview(as: .systemMedium) {
    SergeiCountdownWidget()
} timeline: {
    SimpleEntry(date: .now, launches: nil)
}

@available(iOS 17.0, *)
#Preview(as: .systemLarge) {
    SergeiCountdownWidget()
} timeline: {
    SimpleEntry(date: .now, launches: nil)
}
