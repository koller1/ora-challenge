//
//  Logger.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/23/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import Foundation
import CocoaLumberjack

class Logger {
    
    struct LogDomain: OptionSetType {
        let rawValue: Int
        
        static let General = LogDomain(rawValue: 1 << 0)
        static let Network = LogDomain(rawValue: 1 << 1)
    }
    
    /** The domains of which to display log messages */
    static var activeDomains: LogDomain = [.General, .Network]
    
    static func prepareToLaunch() {
        let loggers = [
            DDTTYLogger.sharedInstance(),
            DDASLLogger.sharedInstance()   
        ]
        
        // a custom log formatter for prettier output
        let formatter = LogFormatter()
        
        // apply the formatter to each logger and register it
        for logger in loggers {
            logger.logFormatter = formatter
            
            DDLog.addLogger(logger)
        }
    }
    
    // MARK: - Logging
    
    static func verbose(message: String, domain: LogDomain = .General) {
        DDLogVerbose(message, tag: domain.rawValue)
    }
    
    static func debug(message: String, domain: LogDomain = .General) {
        DDLogDebug(message, tag: domain.rawValue)
    }
    
    static func info(message: String, domain: LogDomain = .General) {
        DDLogInfo(message, tag: domain.rawValue)
    }
    
    static func warn(message: String, domain: LogDomain = .General) {
        DDLogWarn(message, tag: domain.rawValue)
    }
    
    static func error(message: String, domain: LogDomain = .General) {
        DDLogError(message, tag: domain.rawValue)
    }
}