//
//  Launches.swift
//  Sergei
//
//  Created by Hidemasa Kobayashi on 2025/01/21.
//

import Foundation

// MARK: - Launches Response
struct Launches: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Launch]
}

// MARK: - Launch
struct Launch: Codable, Identifiable {
    let id: String
    let url: String
    let launchLibraryID: Int?
    let slug: String
    let name: String
    let status: LaunchStatus
    let net: String
    let windowEnd: String
    let windowStart: String
    let inhold: Bool
    let tbdtime: Bool
    let tbddate: Bool
    let probability: Int?
    let holdreason: String?
    let failreason: String?
    let hashtag: String?
    let launchServiceProvider: LaunchServiceProvider?
    let rocket: Rocket?
    let mission: Mission?
    let pad: Pad?
    let webcastLive: Bool
    let image: String?
    let infographic: String?
    let program: [Program]
    let orbitalLaunchAttemptCount: Int?
    let locationLaunchAttemptCount: Int?
    let padLaunchAttemptCount: Int?
    let agencyLaunchAttemptCount: Int?
    let orbitalLaunchAttemptCountYear: Int?
    let locationLaunchAttemptCountYear: Int?
    let padLaunchAttemptCountYear: Int?
    let agencyLaunchAttemptCountYear: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, url, slug, name, status, net, windowEnd, windowStart
        case inhold, tbdtime, tbddate, probability, holdreason, failreason
        case hashtag, launchServiceProvider, rocket, mission, pad
        case webcastLive, image, infographic, program
        case orbitalLaunchAttemptCount, locationLaunchAttemptCount
        case padLaunchAttemptCount, agencyLaunchAttemptCount
        case orbitalLaunchAttemptCountYear, locationLaunchAttemptCountYear
        case padLaunchAttemptCountYear, agencyLaunchAttemptCountYear
        case launchLibraryID = "launch_library_id"
    }
}
