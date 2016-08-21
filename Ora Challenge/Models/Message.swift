//
//  Message.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/21/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import Foundation
import Freddy

class Message: Model {
    
    let chatId: Int
    let userId: Int
    let text: String
    let created: NSDate?
    let user: User
    
    // MARK: - JSONDecodable
    
    required init(json: JSON) throws {
        self.chatId  = try json.int("chatId")
        self.userId  = try json.int("userId")
        self.text    = try json.string("message")
        self.created = try json.string("created").toDate()
        self.user    = try json.decode("user")
        
        try super.init(json: json)
    }
    
}