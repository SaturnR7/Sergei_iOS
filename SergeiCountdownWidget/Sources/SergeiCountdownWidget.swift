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
        SimpleEntry(date: Date(), emoji: "😀")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry: SimpleEntry
        switch context.family {
        case .systemSmall:
            entry = SimpleEntry(date: Date(), emoji: "スモール")
        case .systemMedium:
            entry = SimpleEntry(date: Date(), emoji: "ミディアム")
        case .systemLarge:
            entry = SimpleEntry(date: Date(), emoji: "ラージ")
        default:
            entry = SimpleEntry(date: Date(), emoji: "😀")
        }
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, emoji: "😀")
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
    let emoji: String
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
            CountdownSmall()
        case .systemMedium:
            CountdownMedium()
        case .systemLarge:
            CountdownLarge()
        default:
            Text("not supported")
        }
    }
}

// MARK: - Small
struct CountdownSmall: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                VStack(alignment: .leading, spacing: 14) {
                    HStack {
                        Rectangle()
                            .frame(width: 4, height: 46)
                        VStack(alignment: .leading) {
                            Text("Starship")
                                .font(.system(size: 10))
                            Text("2024-02-06 13:21")
                                .font(.system(size: 10))
                            Text("T-000:00:00")
                                .font(.system(size: 16))
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
    var body: some View {
        ZStack {
            Image("img_widget_starship_1")
                .aspectRatio(contentMode: .fill)
            VStack {
                Spacer()
                HStack {
                    VStack(alignment: .leading, spacing: 14) {
                        HStack {
                            Rectangle()
                                .frame(width: 4, height: 46)
                            VStack(alignment: .leading) {
                                Text("Starship")
                                    .font(.system(size: 10))
                                Text("2024-02-06 13:21")
                                    .font(.system(size: 10))
                                Text("T-000:00:00")
                                    .font(.system(size: 16))
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
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 14) {
                HStack {
                    Rectangle()
                        .frame(width: 4, height: 80)
                    VStack(alignment: .leading) {
                        Text("Starship")
                        Text("2024-02-06 13:21")
                        Text("T-000:00:00")
                            .font(.system(size: 26))
                    }
                }
                ForEach(0..<4) { _ in
                    CountdownLargeReady()
                }
            }
            Spacer()
        }
    }
}

struct CountdownLargeReady: View {
    var body: some View {
        HStack {
            Rectangle()
                .frame(width: 4, height: 40)
            VStack(alignment: .leading) {
                Text("Starship")
                Text("2024-02-06 13:21")
            }
        }
    }
}

// MARK: - Preview
@available(iOS 17.0, *)
#Preview(as: .systemSmall) {
    SergeiCountdownWidget()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
    SimpleEntry(date: .now, emoji: "🤩")
}


@available(iOS 17.0, *)
#Preview(as: .systemMedium) {
    SergeiCountdownWidget()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
}

@available(iOS 17.0, *)
#Preview(as: .systemLarge) {
    SergeiCountdownWidget()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
}
