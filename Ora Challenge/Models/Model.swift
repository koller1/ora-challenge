//
//  Model.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/21/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import Foundation
import ObjectMapper

class Model: Mappable {
    
    private (set) var uid: Int!
    
    // MARK: - Mappable
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        uid <- map["id"]
    }
    
}