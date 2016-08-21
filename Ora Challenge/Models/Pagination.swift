//
//  Pagination.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/21/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import Foundation
import Freddy

class Pagination: Model {
    
    let pageCount: Int
    let currentPage: Int
    let hasNextPage: Bool
    let hasPreviousPage: Bool
    let count: Int
    let limit: Int
    
    // MARK: - JSONDecodable
    
    required init(json: JSON) throws {
        self.pageCount       = try json.int("page_count")
        self.currentPage     = try json.int("current_page")
        self.hasNextPage     = try json.bool("has_next_page")
        self.hasPreviousPage = try json.bool("has_prev_page")
        self.count           = try json.int("count")
        self.limit           = try json.int("limit")
        
        try super.init(json: json)
    }
    
}