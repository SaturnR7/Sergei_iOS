//
//  LaunchesRepository.swift
//  Sergei
//
//  Created by Hidemasa Kobayashi on 2025/01/21.
//

import Foundation

protocol LaunchesRepositoryProtocol {
    func fetchLaunches() async throws -> Launches
}

final class LaunchesRepository: LaunchesRepositoryProtocol {
    // MARK: - Properties
    private let apiClient: APIClientProtocol
    
    // MARK: - Initialize
    init(apiClient: APIClientProtocol = APIClient.shared) {
        self.apiClient = apiClient
    }
    
    // MARK: - Methods
    func fetchLaunches() async throws -> Launches {
        let request = LaunchesRequest()
        return try await apiClient.response(request)
    }
}
