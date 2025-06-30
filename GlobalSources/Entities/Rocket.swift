//
//  Rocket.swift
//  Sergei
//
//  Created by Hidemasa Kobayashi on 2025/01/21.
//

import Foundation

// MARK: - Rocket
struct Rocket: Codable {
    let id: Int
    let configuration: RocketConfiguration?
}

// MARK: - Rocket Configuration
struct RocketConfiguration: Codable {
    let id: Int
    let launchLibraryID: Int?
    let url: String
    let name: String
    let family: String?
    let fullName: String?
    let variant: String?
    let alias: String?
    let minStage: Int?
    let maxStage: Int?
    let length: Double?
    let diameter: Double?
    let maidenFlight: String?
    let launchMass: Int?
    let leoCapacity: Int?
    let gtoCapacity: Int?
    let toThrust: Int?
    let apogee: Int?
    let vehicleRange: Int?
    let totalLaunchCount: Int?
    let consecutiveSuccessfulLaunches: Int?
    let successfulLaunches: Int?
    let failedLaunches: Int?
    let pendingLaunches: Int?
    let attemptedLandings: Int?
    let successfulLandings: Int?
    let failedLandings: Int?
    let consecutiveSuccessfulLandings: Int?
    let infoURL: String?
    let wikiURL: String?
    let logoURL: String?
    let imageURL: String?
    let program: [Program]?
    
    enum CodingKeys: String, CodingKey {
        case id, url, name, family, variant, alias, length, diameter
        case maidenFlight, launchMass, leoCapacity, gtoCapacity, toThrust
        case apogee, vehicleRange, totalLaunchCount, consecutiveSuccessfulLaunches
        case successfulLaunches, failedLaunches, pendingLaunches, attemptedLandings
        case successfulLandings, failedLandings, infoURL, wikiURL, logoURL
        case imageURL, program
        case launchLibraryID = "launch_library_id"
        case fullName = "full_name"
        case minStage = "min_stage"
        case maxStage = "max_stage"
        case consecutiveSuccessfulLandings = "consecutive_successful_landings"
    }
} 