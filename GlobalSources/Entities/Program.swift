//
//  Program.swift
//  Sergei
//
//  Created by Hidemasa Kobayashi on 2025/01/21.
//

import Foundation

// MARK: - Program
struct Program: Codable {
    let id: Int?
    let url: String?
    let name: String?
    let description: String?
    let agencies: [Agency]?
    let imageURL: String?
    let startDate: String?
    let endDate: String?
    let infoURL: String?
    let wikiURL: String?
    let missionPatches: [String]?

    enum CodingKeys: String, CodingKey {
        case id, url, name, description, agencies, imageURL, startDate, endDate
        case infoURL, wikiURL, missionPatches
    }
}
