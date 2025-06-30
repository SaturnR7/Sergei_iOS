//
//  Provider.swift
//  SergeiCountdownWidgetExtension
//
//  Created by Hidemasa Kobayashi on 2025/07/01.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    typealias Entry = LaunchTimelineEntry

    // MARK: - Properties
    private let launchesRepository: LaunchesRepositoryProtocol

    // MARK: - Initialize
    init(launchesRepository: LaunchesRepositoryProtocol = LaunchesRepository()) {
        self.launchesRepository = launchesRepository
    }

    func placeholder(in context: Context) -> LaunchTimelineEntry {
        LaunchTimelineEntry(date: Date(), launches: nil)
    }

    func getSnapshot(in context: Context, completion: @escaping (LaunchTimelineEntry) -> ()) {
        let entry = LaunchTimelineEntry(date: Date(), launches: nil)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task {
            var entries: [LaunchTimelineEntry] = []
            let currentDate = Date()

            do {
                let launches = try await launchesRepository.getLaunchesUpcoming()
                // 次の5時間分のエントリを作成
                for hourOffset in 0 ..< 5 {
                    let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
                    let entry = LaunchTimelineEntry(date: entryDate, launches: launches)
                    entries.append(entry)
                }
            } catch {
                // エラーの場合は空のデータでエントリを作成
                for hourOffset in 0 ..< 5 {
                    let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
                    let entry = LaunchTimelineEntry(date: entryDate, launches: nil)
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
