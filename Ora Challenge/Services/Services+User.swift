//
//  Services+User.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/20/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import Foundation

extension Services {
    
    func fetchUser(handler: (User?, NSError?) -> Void) -> NetworkCancelable {
        let request = Request(get: "\(servicesPath)users/me") 
        
        return startRequest(request, parseModel: User.self, handler: handler)
    }
    
}