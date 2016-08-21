//
//  UIViewController+Utility.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/21/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // MARK: - Instantiation
    
    static func instance() -> Self {
        return instanceFromStoryboardNamed(storyboardName, storyboardId: storyboardId)
    }
    
    static func instanceFromStoryboardNamed<T>(storyboardName: String, storyboardId: String) -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier(storyboardId)
        
        if !(controller is T) {
            preconditionFailure("\(storyboardName)'s \(storyboardId) is not an instance of class \(T.self)")
        }
        
        return controller as! T
    }
    
    static var storyboardName: String {
        // default naming convention is {name}Storyboard.storyboard
        return String(self).stringByReplacingOccurrencesOfString("ViewController", withString: "Storyboard")
    }
    
    static var storyboardId: String {
        return String(self)
    }
    
}