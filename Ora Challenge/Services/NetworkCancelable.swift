//
//  NetworkCancelable.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/21/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkCancelable {
    
    /**
     @brief Cancels this network event
     
     If the event has already been canceled, this method does nothing.
     */
    func cancel()
    
}

extension Alamofire.Request: NetworkCancelable { }