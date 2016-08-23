//
//  Pagination.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/21/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import Foundation
import ObjectMapper

class Pagination: Model {
    
    private (set) var pageCount: Int!
    private (set) var currentPage: Int!
    private (set) var hasNextPage: Bool!
    private (set) var hasPreviousPage: Bool!
    private (set) var count: Int!
    private (set) var limit: Int!
    
    // MARK: - Mappable
    
    override func mapping(map: Map) {
        super.mapping(map)
        
        pageCount       <- map["page_count"]
        currentPage     <- map["current_page"]
        hasNextPage     <- map["has_next_page"]
        hasPreviousPage <- map["has_prev_page"]
        count           <- map["count"]
        limit           <- map["limit"]
    }
    
}