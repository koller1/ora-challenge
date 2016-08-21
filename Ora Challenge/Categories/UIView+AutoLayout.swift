//
//  UIView+AutoLayout.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/21/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import UIKit

extension UIView {
    
    /**
     Passthrough to `migrate(_:toView:)` using the receiver's constraints
     */
    func migrateConstraints(view: UIView) -> [NSLayoutConstraint] {
        return migrate(constraints, toView: view)
    }
    
    /**
     Maps the receiever's constraints to the`view`
     
     Any constraint on the receiver that also involves it will be recreated with the `view`
     in its place.
     
     - returns: The newly migrated constraints
     */
    func migrate(constraints: [NSLayoutConstraint], toView view: UIView) -> [NSLayoutConstraint] {
        return constraints.map({ constraint -> NSLayoutConstraint in
            migrateConstraint(constraint, toView: view)
        })
    }
    
    //
    // Helpers
    //
    
    private func migrateConstraint(constraint: NSLayoutConstraint, toView view: UIView) -> NSLayoutConstraint {
        var firstAttribute  = constraint.firstAttribute
        var secondAttribute = constraint.secondAttribute
        
        let firstItem  = migrateItem(constraint.firstItem, attribute:&firstAttribute, toView: view)
        let secondItem: AnyObject? = constraint.secondItem != nil ? migrateItem(constraint.secondItem!, attribute: &secondAttribute, toView: view) : nil
        
        return NSLayoutConstraint(item: firstItem, attribute: firstAttribute, relatedBy: constraint.relation, toItem: secondItem, attribute: secondAttribute, multiplier: constraint.multiplier, constant: constraint.constant)
        
    }
    
    func migrateItem(item: AnyObject, inout attribute: NSLayoutAttribute, toView view: UIView) -> AnyObject {
        var result = item
        
        // if the item is us, migrate to the view
        if item as! NSObject == self {
            result = view
        }
        else if item is UILayoutSupport {
            result = view
            invertAttribute(&attribute)
        }
        
        return result
    }
    
    private func invertAttribute(inout attribute: NSLayoutAttribute) {
        switch attribute {
        case .Bottom:
            attribute = .Top
        case .Top:
            attribute = .Bottom
        default:
            return
        }
    }
}