//
//  SergeiRequestType.swift
//  Sergei
//
//  Created by Hidemasa Kobayashi on 2025/05/26.
//

import APIKit
import Foundation
import Logging

protocol SergeiRequestType: Request {}

// MARK: - Request
extension SergeiRequestType {
    var baseURL: URL {
        URL(string: "https://ll.thespacedevs.com/2.3.0/")!
    }

    var dataParser: any DataParser {
        return JSONDataParser()
    }
}

// MARK: - Intercept URLRequest
extension SergeiRequestType {
    func intercept(urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        urlRequest.timeoutInterval = 30
        return urlRequest
    }
}

// MARK: - Intercept HTTPURLResponse
extension SergeiRequestType {
    func intercept(object: Any, urlResponse: HTTPURLResponse) throws -> Any {
        switch urlResponse.statusCode {
        case 200 ..< 300:
            return object
        default:
            return urlResponse.statusCode
        }
    }
}

// MARK: - Response
extension SergeiRequestType where Response: Decodable {
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        do {
            guard let data = object as? Data else {
                throw ResponseError.unexpectedObject(object)
            }
            return try SergeiAPI.jsonDecoder.decode(Response.self, from: data)
        } catch {
            AppLogger.error("レスポンスエラー")
            throw ResponseError.unexpectedObject(object)
        }
    }
}
