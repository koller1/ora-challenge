//
//  Model.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/21/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import Foundation
import Freddy

class Model: JSONDecodable, JSONEncodable {
    
    let uid: Int
    
    // MARK: - JSONDecodable
    
    required init(json: JSON) throws {
        self.uid = try json.int("id")
    }
    
    // MARK: - JSONEncodable
    
    func toJSON() -> JSON {
        return .Dictionary([
            "id": .Int(uid)
        ])
    }
    
}