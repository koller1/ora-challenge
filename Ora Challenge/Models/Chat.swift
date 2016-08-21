//
//  Chat.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/21/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import Foundation
import Freddy

class Chat: Model {
    
    let userId: Int
    let name: String
    let created: NSDate?
    let user: User
    let lastMessage: Message?
    
    // MARK: - JSONDecodable
    
    required init(json: JSON) throws {
        self.userId      = try json.int("user_id")
        self.name        = try json.string("name")
        self.created     = try json.string("created").toDate()
        self.user        = try json.decode("user")
        self.lastMessage = try json.decode("last_message", alongPath: [.MissingKeyBecomesNil, .NullBecomesNil])
        
        try super.init(json: json)
    }
    
}
