//
//  Services.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/20/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import Foundation
import Alamofire
import Freddy

class Services {
    /** Singleton accessor */
    static var sharedInstance = Services()
    
    /** The base URL for services */
    var servicesPath = "http://private-d9e5b-oracodechallenge.apiary-mock.com/"
    
    /** Client configured for connecting to services */
    private var httpClient: Manager = {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        return Manager(configuration: configuration)
    }()
    
    // MARK: - Parsing
    
    func startRequest(request: Request, handler: ((JSON?, NSError?) -> Void)?) -> NetworkCancelable {
        return startRequest(request, withParser: { (json) -> JSON? in
            return json
        }, handler: handler)
    }
    
    func startRequest<T: JSONDecodable>(request: Request, parseModel klass: T.Type, handler: (T?, NSError?) -> Void) -> NetworkCancelable {
        return startRequest(request, withParser: { json -> T? in
            return try? klass.init(json: json)
        }, handler: handler)
    }
    
    func startRequest<T: JSONDecodable>(request: Request, parseCollection klass: T.Type, handler: ([T]?, NSError?) -> Void) -> NetworkCancelable {
        return startRequest(request, withParser: { json -> [T]? in
            return try? json.arrayOf()
        } , handler: handler)
    }
    
    func startRequest<T>(request: Request, withParser parser: ((JSON) -> T?), handler: ((T?, NSError?) -> Void)?) -> NetworkCancelable {
        
        return httpClient.request(request).validate().responseData(completionHandler: { response in
            var result: T? = nil
            
            if let data = response.data where response.result.isSuccess {
                let json        = try! JSON(data: data).dictionary()
                let jsonData    = json["data"]
                
                result = parser(jsonData!)
            }
            
            handler?(result, response.result.error)
        })
    }
}

extension Manager {
    
    func request(request: Request) -> Alamofire.Request {
        return self.request(request.method, request.url!, parameters: request.parameters, encoding: request.parameterEncoding, headers: request.headers)
    }
}