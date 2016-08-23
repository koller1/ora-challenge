//
//  LogFormatter.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/23/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import Foundation
import CocoaLumberjack

class LogFormatter: NSObject, DDLogFormatter {
    
    // MARK: - DDLogFormatter
    
    @objc func formatLogMessage(logMessage: DDLogMessage!) -> String! {
        return "\(domainNameForMessage(logMessage)) (\(levelNameForMessage(logMessage))), \(logMessage.message)"
    }
    
    private func domainNameForMessage(message: DDLogMessage) -> String {
        guard let tag = message.tag as? Int else {
            return "UNKNOWN   "
        }
        
        let domain = Logger.LogDomain(rawValue: tag)
        
        switch domain {
        case Logger.LogDomain.General:
            return "GENERAL   "
        case Logger.LogDomain.Network:
            return "NETWORK   "
        default:
            return "UNKNOWN   "
        }
    }
    
    private func levelNameForMessage(message: DDLogMessage) -> String{
        switch (message.flag) {
        case DDLogFlag.Error:
            return "E"
        case DDLogFlag.Warning:
            return "W"
        case DDLogFlag.Info:
            return "I"
        case DDLogFlag.Debug:
            return "D"
        case DDLogFlag.Verbose:
            return "V"
        default:
            return "U"
        }
    }
    
}