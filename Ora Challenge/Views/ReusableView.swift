//
//  ReusableView.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/22/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import Foundation

protocol ReusableView {
    /** A reusable identifier for use with recycling mechanisms */
    static func reusableIdentifier() -> String
}


extension ReusableView {
    
    static func reusableIdentifier() -> String {
        return String(self)
    }
    
}