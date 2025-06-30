//
//  Agency.swift
//  Sergei
//
//  Created by Hidemasa Kobayashi on 2025/01/21.
//

import Foundation

// MARK: - Agency
struct Agency: Codable {
    let id: Int?
    let url: String?
    let name: String?
    let type: AgencyType?
    let countryCode: String?
    let abbrev: String?
    let description: String?
    let administrator: String?
    let foundingYear: String?
    let launchers: String?
    let spacecraft: String?
    let launchLibraryURL: String?
    let totalLaunchCount: Int?
    let consecutiveSuccessfulLaunches: Int?
    let successfulLaunches: Int?
    let failedLaunches: Int?
    let pendingLaunches: Int?
    let consecutiveSuccessfulLandings: Int?
    let successfulLandings: Int?
    let failedLandings: Int?
    let attemptedLandings: Int?
    let infoURL: String?
    let wikiURL: String?
    let logoURL: String?
    let imageURL: String?
    let nationURL: String?

    enum CodingKeys: String, CodingKey {
        case id, url, name, type, abbrev, description, administrator
        case foundingYear, launchers, spacecraft, totalLaunchCount
        case consecutiveSuccessfulLaunches, successfulLaunches, failedLaunches
        case pendingLaunches, consecutiveSuccessfulLandings, successfulLandings
        case failedLandings, attemptedLandings, infoURL, wikiURL, logoURL
        case imageURL, nationURL
        case countryCode = "country_code"
        case launchLibraryURL = "launch_library_url"
    }
}

// MARK: - Agency Type
struct AgencyType: Codable {
    let id: Int?
    let name: String?
}
