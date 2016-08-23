//
//  Services+Messages.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/22/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import Foundation

extension Services {
    
    func fetchMessages(chatId: Int, page: Int = 1, limit: Int = 20, handler: ([Message]?, NSError?) -> Void) -> NetworkCancelable {
        let request = Request(get: "\(servicesPath)chats/\(chatId)/messages")
        request.parameters = [
            "page":  page,
            "limit": limit
        ]
        
        return startRequest(request, handler: handler)
    }
    
    func createMessage(chatId: Int, message: String, handler: (Message?, NSError?) -> Void) -> NetworkCancelable {
        let request = Request(post: "\(servicesPath)chats/messagemes\(chatId)/messages")
        request.parameters = [
            "message": message
        ]
        
        return startRequest(request, handler: handler)
    }
    
}