//
//  LaunchesUpcomingRequest.swift
//  SergeiCountdownWidgetExtension
//
//  Created by Hidemasa Kobayashi on 2025/07/01.
//

import APIKit
import Foundation

struct LaunchesUpcomingRequest: SergeiRequestType {
    typealias Response = Launches

    var method: HTTPMethod {
        return .get
    }

    var path: String {
        return "launches/upcoming"
    }
}
