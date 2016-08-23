//
//  NSDate+Utility.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/22/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import Foundation

extension NSDate {
    @nonobjc static let DayGranularity: NSCalendarUnit   = [.Year, .Month, .Day]
    @nonobjc static let MinueGranularity: NSCalendarUnit = [DayGranularity, .Hour, .Minute]
    
    // MARK: - Evaluation
    
    func isToday() -> Bool {
        return isEqual(NSDate(), granularity: NSDate.DayGranularity)
    }
    
    func isSameDay(date: NSDate) -> Bool {
        return isEqual(date, granularity: NSDate.DayGranularity)
    }
    
    func isEqual(other: NSDate, granularity: NSCalendarUnit) -> Bool {
        let result = compare(other, granularity: granularity)
        
        return result == .OrderedSame
    }
    
    func compare(other: NSDate, granularity: NSCalendarUnit) -> NSComparisonResult {
        let date1 = self.clampComponents(granularity)
        let date2 = other.clampComponents(granularity)
        
        return date1.compare(date2)
    }
    
    // MARK: - Componentizing
    
    func components(units: NSCalendarUnit) -> NSDateComponents {
        let components = NSCalendar.currentCalendar().components([units, .Calendar], fromDate: self)
        
        return components
    }
    
    func clampComponents(units: NSCalendarUnit) -> NSDate {
        return components(units).date!
    }
    
}