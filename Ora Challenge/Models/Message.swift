//
//  Message.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/21/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import Foundation
import ObjectMapper

class Message: Model {
    
    private (set) var chatId: Int!
    private (set) var userId: Int!
    private (set) var text: String!
    private (set) var created: NSDate?
    private (set) var user: User!
    
    // MARK: - Mappable
    
    override func mapping(map: Map) {
        super.mapping(map)
        
        chatId  <- map["chat_id"]
        userId  <- map["user_id"]
        text    <- map["message"]
        created <- (map["created"], DateFormatterTransform(dateFormatter: NSDate.servicesFormatter()))
        user    <- map["user"]
    }
    
}