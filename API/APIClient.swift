//
//  APIClient.swift
//  Sergei
//
//  Created by Hidemasa Kobayashi on 2025/05/26.
//

import APIKit
import Foundation

protocol APIClientProtocol: AnyObject {
    func response<Request: SergeiRequestType>(_ request: Request) async throws -> Request.Response
}

final class APIClient: APIClientProtocol {
    // MARK: - Properties
    static let shared: APIClient = .init()

    private static let sharedSession: Session = {
        let configuration = URLSessionConfiguration.default
        let adapter = URLSessionAdapter(configuration: configuration)
        return .init(adapter: adapter)
    }()

    private let session: Session

    // MARK: - Initialize
    init(session: Session = sharedSession) {
        self.session = session
    }

    func response<Request: SergeiRequestType>(_ request: Request) async throws -> Request.Response {
        return try await session.response(for: request)
    }
}
