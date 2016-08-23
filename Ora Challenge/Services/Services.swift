//
//  Services.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/20/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class Services {
    /** Singleton accessor */
    static var sharedInstance = Services()
    
    /** The base URL for services */
    var servicesPath = "http://private-d9e5b-oracodechallenge.apiary-mock.com/"
    
    /** Client configured for connecting to services */
    private var httpClient: Manager = {
        return Services.constructHttpClient()
    }()
    /** Additional headers to send with every request */
    var additionalHeaders: [NSObject: AnyObject]? {
        didSet {
            httpClient = Services.constructHttpClient(headers: additionalHeaders)
        }
    }
    
    static private func constructHttpClient(headers headers: [NSObject: AnyObject]? = nil) -> Manager {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        configuration.HTTPAdditionalHeaders = [
            "Content-Type": "application/json; charset=utf-8",
            "Accept": "application/json"
        ].merge(headers)
        
        return Manager(configuration: configuration)
        
    }
    
    // MARK: - Parsing
    
    func startRequest(request: Request, handler: (([String: AnyObject]?, NSError?) -> Void)?) -> NetworkCancelable {
        return startRequest(request, withParser: nil, handler: handler)
    }
    
    func startRequest<T: Mappable>(request: Request, handler: (T?, NSError?) -> Void) -> NetworkCancelable {
        return startRequest(request, withParser: { json -> T? in
            return Mapper<T>().map(json)
        }, handler: handler)
    }
    
    func startRequest<T: Mappable>(request: Request, handler: ([T]?, NSError?) -> Void) -> NetworkCancelable {
        return startRequest(request, withParser: { json -> [T]? in
            return Mapper<T>().mapArray(json)
        }, handler: handler)
    }
    
    func startRequest<T>(request: Request, withParser parser: ((AnyObject) -> T?)?, handler: ((T?, NSError?) -> Void)?) -> NetworkCancelable {
        
        return httpClient.request(request).validate().responseJSON(completionHandler: { response in
            var result: T? = nil
            
            // pull out data
            let jsonResponse = response.result.value as? [String: AnyObject]
            let jsonData     = jsonResponse?["data"]
            
            // attempt parsing if asked
            if let parser = parser, jsonData = jsonData {
                result = parser(jsonData)
            }
            // otherwise, check if raw response is valid
            else if let jsonData = jsonData as? T {
                result = jsonData
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