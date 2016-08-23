//
//  Chat.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/21/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import Foundation
import ObjectMapper

class Chat: Model {
    
    private (set) var userId: Int!
    private (set) var name: String!
    private (set) var created: NSDate!
    private (set) var user: User!
    private (set) var lastMessage: Message?
    
    // MARK: - Mappable
    
    override func mapping(map: Map) {
        super.mapping(map)
        
        userId      <- map["user_id"]
        name        <- map["name"]
        created     <- (map["created"], DateFormatterTransform(dateFormatter: NSDate.servicesFormatter()))
        user        <- map["user"]
        lastMessage <- map["last_message"]
    }
    
}
