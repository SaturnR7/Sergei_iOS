//
//  LaunchTimelineEntry.swift
//  SergeiCountdownWidgetExtension
//
//  Created by Hidemasa Kobayashi on 2025/07/01.
//

import Foundation
import WidgetKit

struct LaunchTimelineEntry: TimelineEntry {
    let date: Date
    let launches: Launches?
}
