//
//  User.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/21/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import Foundation
import Freddy

class User: Model {
    
    let name: String
    let email: String?
    let token: String?
    
    // MARK: - JSONDecodable
    
    required init(json: JSON) throws {
        self.name  = try json.string("name")
        self.email = try json.string("email", alongPath: [.MissingKeyBecomesNil, .NullBecomesNil])
        self.token = try json.string("token", alongPath: [.MissingKeyBecomesNil, .NullBecomesNil])
        
        try super.init(json: json)
    }
    
}