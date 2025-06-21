//
//  JSONDataParser.swift
//  Sergei
//
//  Created by Hidemasa Kobayashi on 2025/05/26.
//

import APIKit
import Foundation

final class JSONDataParser: DataParser {
    let contentType: String? = "application/json"

    func parse(data: Data) throws -> Any {
        return data
    }
}
