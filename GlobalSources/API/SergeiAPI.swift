//
//  SergeiAPI.swift
//  Sergei
//
//  Created by Hidemasa Kobayashi on 2025/05/26.
//

import Foundation

struct SergeiAPI {}

extension SergeiAPI {
    static let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }()
}
