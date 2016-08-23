//
//  User.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/21/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import Foundation
import ObjectMapper

class User: Model {
    
    private (set) var name: String?
    private (set) var email: String?
    private (set) var token: String!
    
    // MARK: - Mappable
    
    override func mapping(map: Map) {
        super.mapping(map)
        
        name  <- map["id"]
        email <- map["email"]
        token <- map["token"]
    }
}