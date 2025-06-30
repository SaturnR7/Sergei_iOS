//
//  AppLogger.swift
//  Sergei
//
//  Created by Hidemasa Kobayashi on 2025/05/26.
//

import Foundation
import Logging

final class AppLogger {
    private static let swiftLogger: Logger = {
        LoggingSystem.bootstrap { label in
            EmojiLogHandler(label: label)
        }
        let logger = Logger(label: "aaa")
        return logger
    }()
}

// MARK: - Log
extension AppLogger {
    static func trace(_ message: String) {
        swiftLogger.trace("\(message)")
    }

    static func debug(_ message: String) {
        swiftLogger.debug("\(message)")
    }

    static func info(_ message: String) {
        swiftLogger.info("\(message)")
    }

    static func notice(_ message: String) {
        swiftLogger.notice("\(message)")
    }

    static func warning(_ message: String) {
        swiftLogger.warning("\(message)")
    }

    static func error(_ message: String) {
        swiftLogger.error("\(message)")
    }

    static func critical(_ message: String) {
        swiftLogger.critical("\(message)")
    }
}

// MARK: - Modify Log
struct EmojiLogHandler: LogHandler {
    var logLevel: Logger.Level = .info
    var metadata: Logger.Metadata = [:]
    let label: String

    subscript(metadataKey key: String) -> Logger.Metadata.Value? {
        get { metadata[key] }
        set { metadata[key] = newValue }
    }

    func log(
        level: Logger.Level,
        message: Logger.Message,
        metadata: Logger.Metadata?,
        source: String,
        file: String,
        function: String,
        line: UInt
    ) {
        let prefix: String
        switch level {
        case .trace:
            prefix = "🫆[TRACE]🫆"
        case .debug:
            prefix = "🤖[DEBUG]🤖"
        case .info:
            prefix = "📝[INFO]📝"
        case .notice:
            prefix = "📢[NOTICE]📢"
        case .warning:
            prefix = "⚠️[WARN]⚠️"
        case .error:
            prefix = "🚨[ERROR]🚨"
        case .critical:
            prefix = "‼️[CRITICAL]‼️"
        }
        print("\(prefix) \(message)")
    }
}
