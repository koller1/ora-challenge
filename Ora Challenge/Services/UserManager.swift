//
//  UserManager.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/22/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import Foundation

class UserManager {
    typealias UserManagerHandler = (User?, NSError?) -> Void
    
    /** Singleton accessor */
    static var sharedInstance = UserManager()
    
    /** The presently authenticated user */
    private (set) var currentUser: User? {
        didSet {
            didSetUser(currentUser)
        }
    }
    
    // MARK: - Registration
    
    func registerWithName(name name: String, email: String, password: String, confirm: String, handler: UserManagerHandler) {
        Services.sharedInstance.register(name: name, email: email, password: password, confirm: confirm) { (user, error) in
            self.currentUser = user
            
            handler(user, error)
        }
    }
    
    // MARK: - Login
    
    func authenticateWithEmail(email: String, password: String, handler: UserManagerHandler) {
        Services.sharedInstance.login(email: email, password: password) { (user, error) in
            self.currentUser = user
            
            handler(user, error)
        }
    }
    
    // MARK: User Management
    
    func updateUser(user: User, handler: UserManagerHandler) {
        // TODO: Implement
    }
    
    private func didSetUser(user: User?) {
        // make sure outgoing requests are authenticated with latest user
        updateAuthenticationHeaders(user)
    }
    
    private func updateAuthenticationHeaders(user: User?) {
        var headers: [NSObject: AnyObject] = [:]
        
        if let token = user?.token {
            headers["Authorization"] = "Bearer \(token)"
        }
        
        Services.sharedInstance.additionalHeaders = headers
    }
}