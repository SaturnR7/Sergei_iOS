//
//  Mission.swift
//  Sergei
//
//  Created by Hidemasa Kobayashi on 2025/01/21.
//

import Foundation

// MARK: - Mission
struct Mission: Codable {
    let id: Int?
    let launchLibraryID: Int?
    let name: String?
    let description: String?
    let launchDesignator: String?
    let type: String?
    let orbit: Orbit?

    enum CodingKeys: String, CodingKey {
        case id, name, description, type, orbit
        case launchLibraryID = "launch_library_id"
        case launchDesignator = "launch_designator"
    }
}

// MARK: - Orbit
struct Orbit: Codable {
    let id: Int?
    let name: String?
    let abbrev: String?
}
