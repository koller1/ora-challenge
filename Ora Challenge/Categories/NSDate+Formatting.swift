//
//  NSDate+Formatting.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/21/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import Foundation

extension String {
    
    func toDate() -> NSDate? {
        return NSDate.dateFromString(self, withFormat: NSDate.servicesDateFormat)
    }
    
}

extension NSDate {
    // see http://stackoverflow.com/questions/29814706/a-declaration-cannot-be-both-final-and-dynamic-error-in-swift-1-2/32831677
    // for @nonobjc explanation
    @nonobjc static let servicesDateFormat = "asdf"
    
    static func dateFromString(string: String, withFormat format: String) -> NSDate? {
        let formatter = formatterForFormat(format)
        let date      = formatter.dateFromString(string)
        
        return date;
    }
    
    // MARK: - Formatter Caching
    
    static private func formatterForFormat(format: String) -> NSDateFormatter {
        let key = "com.\(String(self)).\(format)"
        
        var formatter = formatterForKey(key)
        
        if formatter == nil {
            formatter = createFormatterForKey(key)
            formatter?.dateFormat = format
        }
        
        return formatter!
    }
    
    //
    // Helpers
    //
    
    static private func formatterForKey(key: String) -> NSDateFormatter? {
        return NSThread.currentThread().threadDictionary[key] as? NSDateFormatter
    }
    
    static private func createFormatterForKey(key: String) -> NSDateFormatter {
        let formatter       = NSDateFormatter()
        formatter.locale    = NSLocale.autoupdatingCurrentLocale()
        formatter.timeZone  = NSTimeZone.localTimeZone()
        
        NSThread.currentThread().threadDictionary[key] = formatter
        
        
        return formatter
    }
}