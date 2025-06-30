//
//  LaunchRequest.swift
//  Sergei
//
//  Created by Hidemasa Kobayashi on 2025/05/26.
//

import APIKit
import Foundation

extension SergeiAPI {
    struct GetLaunchRequest: SergeiRequestType {
        typealias Response = String

        // MARK: - Properties

        // MARK: - Request Type
        public let method: HTTPMethod = .get
        public let path: String = "/launches"
    }
}
