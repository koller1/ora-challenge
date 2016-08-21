//
//  UIView+Unarchiving.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/21/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import UIKit

extension UIView {
    
    /**
     Generates an instance of this class from a nib of the same name
     
     - returns: A new instance of Self
     */
    static func instanceFromNib() -> Self {
        return instanceFromNibWithName(String(self))
    }
    
    /**
     Generates a view from a particular nib
     
     Will load up the nib named `name` and attempt to return the first
     view found. It's considered a fatal error to be missing the nib or
     be unable to cast the nib's view to the appropriate class.
     
     - returns: A new UIView instance
     */
    static func instanceFromNibWithName<T: UIView> (name: String) -> T {
        guard let view = NSBundle.mainBundle().loadNibNamed(name, owner: nil, options: nil).first else {
            preconditionFailure("Missing nib with name \(name)")
        }
        
        guard let result: T = view as? T else {
            preconditionFailure("Nib named \(name) does not contain view of type \(String(T.self))")
        }
        
        return result
    }
    
}