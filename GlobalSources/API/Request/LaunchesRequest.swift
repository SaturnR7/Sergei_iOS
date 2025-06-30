//
//  LaunchesRequest.swift
//  Sergei
//
//  Created by Hidemasa Kobayashi on 2025/01/21.
//

import APIKit
import Foundation

struct LaunchesRequest: SergeiRequestType {
    typealias Response = Launches
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return "launches"
    }
    
    var parameters: Any? {
        return nil
    }
} 
