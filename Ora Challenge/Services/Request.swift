//
//  Request.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/20/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import Foundation
import Alamofire
import Freddy

class Request {
    
    let url: NSURL?
    let method: Alamofire.Method
    var headers: [String: String]?
    var parameters: [String: AnyObject]?
    var parameterEncoding: ParameterEncoding {
        return method == .POST ? .JSON : .URL
    }
    
    convenience init(get path: String) {
        self.init(path: path, method: .GET)
    }
    
    convenience init(post path: String) {
        self.init(path: path, method: .POST)
    }
    
    convenience init(put path: String) {
        self.init(path: path, method: .PUT)
    }
    
    convenience init(delete path: String) {
        self.init(path: path, method: .DELETE)
    }
    
    init(path: String, method: Alamofire.Method) {
        self.url    = NSURL(string: path)
        self.method = method
    }
}

