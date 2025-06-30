//
//  WidgetAPIClient.swift
//  Sergei
//
//  Created by Hidemasa Kobayashi on 2025/01/21.
//

import Foundation
import APIKit

class WidgetAPIClient {
    static let shared = WidgetAPIClient()

    private init() {}

    func fetchLaunches(completion: @escaping (Result<Launches, Error>) -> Void) {
        let request = LaunchesRequest()

        // デバッグ用：実際のURLを出力
        print("🔗 Requesting URL: \(request.baseURL)\(request.path)")

        Session.shared.send(request) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let launches):
                    print("✅ API Success: \(launches.count) launches")
                    completion(.success(launches))
                case .failure(let error):
                    print("❌ API Error: \(error)")

                    // デバッグ用：生のレスポンスを確認
                    switch error {
                    case .responseError(let responseError):
                        if let responseError = responseError as? ResponseError {
                            print("Response Error: \(responseError)")

                            // 実際のレスポンスデータを確認
                            if case .unexpectedObject(let object) = responseError {
                                if let data = object as? Data {
                                    print("📄 Raw Response (first 1000 chars): \(String(data: data.prefix(1000), encoding: .utf8) ?? "Unable to decode")")
                                }
                            }
                        }
                    default:
                        print("Session Error: \(error)")
                    }
                    completion(.failure(error))
                }
            }
        }
    }
} 
