//
//  Pad.swift
//  Sergei
//
//  Created by Hidemasa Kobayashi on 2025/01/21.
//

import Foundation

// MARK: - Pad
struct Pad: Codable {
    let id: Int
    let url: String
    let agencyID: Int?
    let name: String
    let infoURL: String?
    let wikiURL: String?
    let mapURL: String?
    let latitude: String?
    let longitude: String?
    let location: Location?
    let countryCode: String?
    let mapImage: String?
    let totalLaunchCount: Int?
    let orbitalLaunchAttemptCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, url, name, infoURL, wikiURL, mapURL, latitude, longitude
        case location, mapImage, totalLaunchCount, orbitalLaunchAttemptCount
        case agencyID = "agency_id"
        case countryCode = "country_code"
    }
}

// MARK: - Location
struct Location: Codable {
    let id: Int
    let url: String
    let name: String
    let countryCode: String?
    let mapImage: String?
    let timezoneName: String?
    let totalLaunchCount: Int?
    let totalLandingCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, url, name, mapImage, totalLaunchCount, totalLandingCount
        case countryCode = "country_code"
        case timezoneName = "timezone_name"
    }
} 