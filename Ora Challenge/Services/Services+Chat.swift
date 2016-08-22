//
//  Services+Chat.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/22/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import Foundation

extension Services {
    
    func fetchChats(query: String, page: Int = 1, limit: Int = 20, handler: ([Chat]?, NSError?) -> Void) -> NetworkCancelable {
        let request = Request(get: "\(servicesPath)/chats")
        request.parameters = [
            "q":     query,
            "page":  page,
            "limit": limit
        ]
        
        return startRequest(request, parseCollection: Chat.self, handler: handler)
    }
    
    func createChat(name: String, handler: (Chat?, NSError?) -> Void) -> NetworkCancelable {
        let request = Request(post: "\(servicesPath)/chats")
        request.parameters = [
            "name": name
        ]
        
        return startRequest(request, parseModel: Chat.self, handler: handler)
    }
}