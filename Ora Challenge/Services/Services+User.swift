//
//  Services+User.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/20/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import Foundation

extension Services {
    typealias UserServicesHandler = (User?, NSError?) -> Void
    
    func register(name name: String, email: String, password: String, confirm: String, handler: UserServicesHandler) -> NetworkCancelable {
        let request = Request(post: "\(servicesPath)users/register")
        request.parameters = [
            "name":     name,
            "email":    email,
            "password": password,
            "confirm":  confirm
        ]
        
        return startRequest(request, handler: handler)
    }
    
    func login(email email: String, password: String, handler: UserServicesHandler) -> NetworkCancelable {
        let request = Request(post: "\(servicesPath)users/login")
        request.parameters = [
            "email":    email,
            "password": password
        ]
        
        return startRequest(request, handler: handler)
    }
    
    func fetchUser(handler: UserServicesHandler) -> NetworkCancelable {
        let request = Request(get: "\(servicesPath)users/me") 
        
        return startRequest(request, handler: handler)
    }
    
    func updateUser(user: User, handler: UserServicesHandler) -> NetworkCancelable {
        let request = Request(put: "\(servicesPath)users/me")
//        request.parameters = user
        
        return startRequest(request, handler: handler)
    }
    
}