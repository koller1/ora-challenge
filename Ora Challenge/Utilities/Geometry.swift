//
//  Geometry.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/23/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import UIKit

public let M_3_PI_2: Double = 1.5 * M_PI

extension CGRect {
    
    var topLeft: CGPoint {
        return origin
    }
    
    var topRight: CGPoint {
        return CGPoint(x: maxX, y: minY)
    }
    
    var bottomLeft: CGPoint {
        return CGPoint(x: minX, y: maxY)
    }
    
    var bottomRight: CGPoint {
        return CGPoint(x: maxX, y: maxY)
    }
    
}
  