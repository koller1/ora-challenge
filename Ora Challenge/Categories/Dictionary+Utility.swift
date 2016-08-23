//
//  Dictionary+Utility.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/23/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import Foundation

extension Dictionary {
    
    /** 
     Merges two dictionaries together
     
     Combined the key/value pairs of one dictionary with
     those of another. If both dictionaries contain a value for
     the same key, `other` takes precedence and will overwrite the
     value in the receiver
     */
    func merge(other: [Key: Value]?) -> [Key: Value] {
        var mergedDictionary = self
        
        for (key, value) in other ?? [:] {
            // given precedence to dictionary parameter
            mergedDictionary[key] = value
        }
        
        return mergedDictionary
    }
    
}